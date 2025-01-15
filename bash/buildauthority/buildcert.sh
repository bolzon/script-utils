# building request
openssl genrsa -des3 -out smime.key 4096
openssl req -new -key smime.key -out smime.csr

# building cert
openssl x509 -req -days 365 -in smime.csr -CA myca.crt -CAkey myca.key -set_serial 1 -out smime.crt -setalias "MyCert SMIME" -addtrust emailProtection -addreject clientAuth -addreject serverAuth -trustout

# exporting as PKCS#12
openssl pkcs12 -export -in smime.crt -inkey smime.key -out smime.p12
