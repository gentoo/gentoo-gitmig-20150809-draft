# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <grant@gentoo.org>, Jano Lukac <jano@portablehole.net>
# $Header: /var/cvsroot/gentoo-x86/incoming/kerberos/krb5-1.2.2-r6.ebuild,v 1.1 2001/12/05 22:04:20 danarmak Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}/src
SRC_URI="http://www.crypto-publish.org/dist/mit-kerberos5/${A}"
DESCRIPTION="MIT Kerberos V (set up for pam)"
HOMEPAGE="http://crypto-publish.org"

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}

	# Got this stuff from redhat's rpm
	cp ${FILESDIR}/statglue.c ${S}/util/profile
	patch -d ${S}/util/profile < ${FILESDIR}/krb5-1.2.2-statglue.patch

}

src_compile() {

	try ./configure --enable-shared --prefix=/usr --mandir=/usr/share/man \
		--without-tcl --localstatedir=/etc
	mv Makefile Makefile.orig

	#Don't install the ftp, telnet, r* apps; use pam instead
	sed -e 's/ appl //' Makefile.orig > Makefile

	try make all-unix
	cd ${S}/clients
	try make all-unix

}

src_install () {

	cd ${S}
	try make DESTDIR=${D} install
	cd ${S}/clients
	try make DESTDIR=${D} install
	dodoc config-files/krb5.conf

	dodoc ${S}/README

	exeinto /etc/init.d
	newexe ${FILESDIR}/kerberos.rc6 kerberos

	echo 'NOTE: ftp, telnet, r* apps not installed.  Install pam-krb5!'
	echo 'Remember to setup dns and create /etc/krb5.conf'

}

