#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-ldap/files/1.03-r3/qmail-genrsacert.sh,v 1.1 2004/01/11 07:08:52 robbat2 Exp $
# Robin H. Johnson <robbat2@gentoo.org> - October 17, 2003
# This file generates the static temporary RSA keys needed for qmail to encrypt messages
# It should be run from a crontab, once a day is ok on low load machines, but
# if you do lots of mail, once per hour is more reasonable
# if you do NOT create the rsa512.pem, qmail will generate it on the fly for
# each connection, which can be VERY slow.

if [ -z "${ROOT}" -o "${ROOT}" = "/" ]; then
confdir=/var/qmail/control
else
confdir=${ROOT}/var/qmail/control
fi
pemfile="${confdir}/rsa512.pem"
tmpfile="${confdir}/rsa512.pem.tmp"

# this is the number of bits in the key
# it should be a power of 2 ideally
# and it must be more than 64!
bits="512"

# the key should be 0600
# which is readable by qmaild only!
umaskvalue="0077"
uid="qmaild"
gid="qmail"

umask ${umaskvalue} ; 
# we need to make sure that all of the operations succeed
/usr/bin/openssl genrsa -out ${tmpfile} ${bits} 2>/dev/null && \
/bin/chown ${uid}:${gid} ${tmpfile} && \
/bin/mv -f ${tmpfile} ${pemfile}
