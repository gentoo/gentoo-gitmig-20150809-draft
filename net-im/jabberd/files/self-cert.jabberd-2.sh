#!/bin/bash

######
#
# Generate a certificate and key with no passphrase.
#
######

OPENSSL=/usr/bin/openssl

## Remove existing temporary private key
test -f /tmp/privkey.pem && rm -f /tmp/privkey.pem
## Remove existing private key
test -f /etc/jabberd/gentoo.pem && rm -f /etc/jabberd/gentoo.pem
## This generates the cert and key
$OPENSSL req -new -x509 -newkey rsa:2048 -keyout /tmp/privkey.pem -out /etc/jabberd/gentoo.pem
## This will remove the passphrase
$OPENSSL rsa -in /tmp/privkey.pem -out /tmp/privkey.pem
## Put it all together
cat /tmp/privkey.pem >> /etc/jabberd/gentoo.pem
## Cleanup
rm -f /tmp/privkey.pem
echo ""
echo "Your new key is /etc/jabberd/gentoo.pem"
echo ""
