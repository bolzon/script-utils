import java.io.FileWriter;
import java.io.InputStream;
import java.security.Key;
import java.security.KeyStore;
import java.util.Base64;

/**
 * This class extracts the private key from a Java Key Store file.
 * @author Bolzon <blzn@mail.ru>
 * @date Aug 19, 2019
 */
public class KS {

  private final static String PRIVATEKEYPATH = "cert.key";
  private final static String KEYSTOREPATH = "keystore.jks";

  public static void main(String[] args) {
    try {
      KeyStore store = readStore();
      Key key = store.getKey("1", "".toCharArray()); // key password is empty
      String strKey = Base64.getEncoder().encodeToString(key.getEncoded());

      System.out.println("Key algorithm : " + key.getAlgorithm());
      System.out.println("Key format    : " + key.getFormat());
      System.out.println("Key file      : " + PRIVATEKEYPATH);

      FileWriter fw = new FileWriter(PRIVATEKEYPATH);
      fw.write("-----BEGIN PRIVATE KEY-----\n");

      int offset = 0;
      while (offset < strKey.length()) {
        fw.write(strKey.substring(offset, Math.min(offset + 64, strKey.length())) + "\n");
        offset += 64;
      }

      fw.write("-----END PRIVATE KEY-----\n");
      fw.close();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  private static KeyStore readStore() throws Exception {
    try (InputStream keyStoreStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(KEYSTOREPATH)) {
      if (keyStoreStream == null) {
        throw new RuntimeException("Key store could not be loaded");
      }
      KeyStore keyStore = KeyStore.getInstance("JKS");
      keyStore.load(keyStoreStream, null); // key store password is null
      return keyStore;
    }
  }
}
