#!/bin/sh
##
##  gencert.sh -- Create self-signed test certificate
##  Christian Zoffoli <czoffoli@linux-mandrake.com> 
##  Version 0.2 - 20010501
##
##


### external tools
openssl="/usr/bin/openssl"

### some optional terminal sequences
case $TERM in
    xterm|xterm*|vt220|vt220*)
        T_MD=`echo dummy | awk '{ printf("%c%c%c%c", 27, 91, 49, 109); }'`
        T_ME=`echo dummy | awk '{ printf("%c%c%c", 27, 91, 109); }'`
        ;;
    vt100|vt100*)
        T_MD=`echo dummy | awk '{ printf("%c%c%c%c%c%c", 27, 91, 49, 109, 0, 0); }'`
        T_ME=`echo dummy | awk '{ printf("%c%c%c%c%c", 27, 91, 109, 0, 0); }'`
        ;;
    default)
        T_MD=''
        T_ME=''
        ;;
esac

#   find some random files
#   (do not use /dev/random here, because this device 
#   doesn't work as expected on all platforms)
randfiles=''
for file in /var/log/messages /var/adm/messages \
            /kernel /vmunix /vmlinuz \
            /etc/hosts /etc/resolv.conf; do
    if [ -f $file ]; then
        if [ ".$randfiles" = . ]; then
            randfiles="$file"
        else
            randfiles="${randfiles}:$file"
        fi
    fi
done


echo ""
echo "${T_MD}"
echo "----------------------------------------------------------------------"
echo "Create self-signed test certificate"
echo ""
echo "Christian Zoffoli <czoffoli@linux-mandrake.com> "
echo "Version 0.2 - 20010501"
echo ""
echo ""
echo "______________________________________________________________________${T_ME}"
echo ""
echo ""


if [ ! -e ./ldap.pem ];then 
	echo "Will create ldap.pem in `pwd`"
else
	echo "ldap.pem already exist, dying"
	exit
fi


mkdir -p /tmp/tmpssl-$$
pushd /tmp/tmpssl-$$ > /dev/null

echo ""
echo ""
echo "${T_MD}Generating Certificate "
echo "______________________________________________________________________${T_ME}"
echo ""


COMMONNAME=`hostname`

if [ ! -n "$COMMONNAME" ]
		then
		COMMONNAME="www.openldap.org"
fi
#. /etc/sysconfig/i18n
if [ -n "$COUNTRY" ]
		then
		COUNTRY=`echo $LANG | sed -e "s/.*_//;s/@.*//;s/\..*//;s/_.*//" |tr a-z A-Z`
else
	COUNTRY="US"	
fi

cat >.cfg <<EOT
[ req ]
default_bits                    = 1024
distinguished_name              = req_DN
RANDFILE                        = ca.rnd
[ req_DN ]
countryName                     = "1. Country Name             (2 letter code)"
countryName_default             = "$COUNTRY"
countryName_min			= 2
countryName_max			= 2
stateOrProvinceName		= "2. State or Province Name   (full name)    "
stateOrProvinceName_default	= ""
localityName                    = "3. Locality Name            (eg, city)     "
localityName_default		= ""
0.organizationName		= "4. Organization Name        (eg, company)  "
0.organizationName_default	= "LDAP Server"
organizationalUnitName		= "5. Organizational Unit Name (eg, section)  "
organizationalUnitName_default	= "For testing purposes only"
commonName			= "6. Common Name              (eg, CA name)  "
commonName_max			= 64
commonName_default		= "$COMMONNAME"
emailAddress			= "7. Email Address            (eg, name@FQDN)"
emailAddress_max		= 40
emailAddress_default		= ""
EOT

$openssl req -config .cfg -new  -rand $randfiles -x509 -nodes -out ldap.pem -keyout ldap.pem -days 999999  

if [ $? -ne 0 ]; then
       	echo "cca:Error: Failed to generate certificate " 1>&2
	exit 1
fi


popd >/dev/null


rm -f /tmp/tmpssl-$$/*.csr
rm -f /tmp/tmpssl-$$/ca.*
chmod 400 /tmp/tmpssl-$$/*

echo "Certificate creation done!"
cp /tmp/tmpssl-$$/ldap.* .
chown ldap.ldap ldap.*

rm -rf /tmp/tmpssl-$$


