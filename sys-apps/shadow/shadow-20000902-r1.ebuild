# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-20000902-r1.ebuild,v 1.1 2000/12/11 05:05:03 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="http://www1.itnet.pl/amelektr/linux/shadow/${A}
	 ftp://piast.t19.ds.pwr.wroc.pl/pub/linux/shadow/${A}"
DEPEND=">=sys-libs/pam-0.72"

src_compile() {                           
	try ./configure --disable-desrpc --with-libcrypt  \
	--with-libcrack --with-libpam --disable-shared --host=${CHOST}
	# Parallel make fails sometimes
	try make LDFLAGS=\"\"
}

src_install() {                               
	cd ${S}
	try make install prefix=${D}/usr exec_prefix=${D}
	mv ${D}/lib ${D}/usr
	dosed "s:/lib:/usr/lib:" /usr/lib/libshadow.la
	cd ${D}/usr/sbin
	ln -s useradd ${D}/usr/sbin/adduser
	dodir /etc
	cp ${O}/files/login.defs ${D}/etc
	
	dodir /etc/defaults
	cp ${O}/files/useradd ${D}/etc/defaults
	chmod 0600 ${D}/etc/defaults/useradd
	dodir /etc/skel
	cd ${S}/etc
	cp shells shells.orig
	echo "# /etc/shells: valid login shells" > shells
	echo "/bin/sh" >> shells
	echo "/bin/bash" >> shells
	echo "/bin/tcsh" >> shells
	echo "/bin/esh" >> shells
	echo "/bin/ksh" >> shells
	echo "/bin/zsh" >> shells
	echo "/bin/sash" >> shells
	insinto /etc
	doins limits shells 
	insopts -m0600
	doins suauth login.access
	doins ${S}/debian/securetty
	cd ${S}/doc
	dodoc ANNOUNCE CHANGES INSTALL LICENSE README WISHLIST 
	docinto txt
	dodoc HOWTO LSM README.* *.txt

}



