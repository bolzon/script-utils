openssl genrsa -des3 -out myca.key 4096
openssl req -new -x509 -days 365 -key myca.key -out myca.crt
