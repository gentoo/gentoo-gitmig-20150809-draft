# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-20001016.ebuild,v 1.1 2001/01/18 18:31:53 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${A}"

DEPEND=">=sys-libs/pam-0.72"

src_unpack() {
  unpack ${A}
  cd ${S}/src
  patch -p0 < ${FILESDIR}/useradd.diff
}

src_compile() {                           
	try ./configure --disable-desrpc --with-libcrypt  \
	--with-libcrack --with-libpam --host=${CHOST}
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
	
	dodir /etc/default
	cp ${O}/files/useradd ${D}/etc/default
	chmod 0600 ${D}/etc/default/useradd
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



