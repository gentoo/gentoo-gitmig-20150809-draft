#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/mail-mta/qmail/files/qmail-dhparam.sh,v 1.1 2006/06/15 00:54:51 robbat2 Exp $
# Robin H. Johnson <robbat2@gentoo.org> - Sept 5, 2005
# This file generates the static temporary DH parameter keys needed for qmail to encrypt messages
# It should be run from a crontab, once a day is ok on low load machines, but
# if you do lots of mail, once per hour is more reasonable
# if you do NOT create the dh512.pem/dh1024.pem, qmail will generate it on the fly for
# each connection, which can be VERY slow.

# this is the number of bits in the key
# it should be a power of 2 ideally
# and it must be more than 64!
# set this to 512 only if you are using export grade encryption
# and configure tls*ciphers for qmail
bits="1024 512"

for b in $bits ; do 
	if [ -z "${ROOT}" -o "${ROOT}" = "/" ]; then
	confdir=/var/qmail/control
	else
	confdir=${ROOT}/var/qmail/control
	fi
	pemfile="${confdir}/dh${b}.pem"
	tmpfile="${confdir}/dh${b}.pem.tmp"
	
	# the key should be 0600
	# which is readable by qmaild only!
	umaskvalue="0077"
	uid="qmaild"
	gid="qmail"
	
	umask ${umaskvalue} ; 
	# we need to make sure that all of the operations succeed
	/usr/bin/openssl dhparam -out ${tmpfile} ${b} 2>/dev/null && \
	/bin/chown ${uid}:${gid} ${tmpfile} && \
	/bin/mv -f ${tmpfile} ${pemfile}
done
