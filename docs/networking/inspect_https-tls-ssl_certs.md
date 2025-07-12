# Inspecting HTTPS (TLS, SSL) certificates from the command line

I needed to inspect an HTTPS site's current certs and wanted to do it from the command line. Here are a couple of commands that I used that worked quite well.

## With nmap

```
nmap -p 443 --script ssl-cert [hostname]
```

## With cURL

```
curl -vvI https://[server URL]
```

cURL will report some certificate information in its versbose output when connecting to an HTTPS URL. *Note: it seems that recent versions of curl won't report much info on the cert.*

## With OpenSSL

```
openssl s_client -showcerts -connect [server domain name]:443
```

I like this method, becase OpenSSL will report a lot of details about the certificates, including the full CA chain, if available.

## Some additional useful commands

### Inspecting a PEM certificate

```
openssl x509 -in [PEM file] -text
```


### Extracting certificate and private key from a PKCS12

I recently wanted to change the configuration on an application server, moving the TLS termination from a Tomcat server to NGINX proxy. I needed to extract the certificate and private key from the original PKCS12 store. Here's how I did that:

```
openssl pkcs12 -in ./[pkcs12 file] -clcerts -nokeys -out public.crt
openssl pkcs12 -in ./[pkcs12 files] -nocerts -nodes -out private.rsa
```