######
#
# Generate a certificate and key with no passphrase.
#
######

OPENSSL=/usr/bin/openssl

## This generates the cert and key
$OPENSSL req -new -x509 -newkey rsa:1024 -keyout /tmp/privkey.pem -out /etc/jabber/gentoo.pem
## This will remove the passphrase
$OPENSSL rsa -in /tmp/privkey.pem -out /tmp/privkey.pem
## Put it all together
cat /tmp/privkey.pem >> /etc/jabber/gentoo.pem
## Cleanup
rm /tmp/privkey.pem
echo ""
echo "Your new key is /etc/jabber/gentoo.pem"
echo ""
