# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-20000902.ebuild,v 1.1 2000/11/26 14:07:14 achim Exp $

A=${P}.tar.gz
#A0=shadow-19990827-redhat.patch
S=${WORKDIR}/${P}
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="http://www1.itnet.pl/amelektr/linux/shadow/${A}
	 ftp://piast.t19.ds.pwr.wroc.pl/pub/linux/shadow/${A}"

src_compile() {                           
	try ./configure --disable-desrpc --with-libcrypt  \
	--with-libcrack --with-libpam --disable-shared --host=${CHOST}
	try make
}

src_install() {                               
        cd ${S}
        try make install prefix=${D}/usr exec_prefix=${D}
	cd ${D}/usr/sbin
	ln -s useradd ${D}/usr/sbin/adduser
	gzip -9 ${D}/usr/man/man?/*.[1-9]
	cd ${D}/usr/man/man8
	ln -s useradd.8.gz adduser.8.gz
	ln -s pwconv.8.gz pwuconv.8.gz
	ln -s pwconv.8.gz grpconv.8.gz
	ln -s pwconv.8.gz grpunconv.8.gz
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
	insinto /etc
	doins limits shells 
	insopts -m0600
	doins suauth login.access
        cd ${S}
        dodoc ABOUT-NLS
	cd ${S}/doc
	dodoc ANNOUNCE CHANGES HOWTO INSTALL LICENSE LSM README* WISHLIST *.txt

}



