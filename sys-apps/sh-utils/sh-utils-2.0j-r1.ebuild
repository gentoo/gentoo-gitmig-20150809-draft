
# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sh-utils/sh-utils-2.0j-r1.ebuild,v 1.7 2000/12/01 21:58:45 achim Exp $

P=sh-utils-2.0j
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Your standard GNU shell utilities"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"
DEPEND=">=sys-libs/glibc-2.1.3"
RDEPEND="$DEPEND
	 >=sys-apps/bash-2.04"

src_unpack() {
  unpack ${A}
  cd ${S}/src
  cp sys2.h sys2.h.orig
  sed -e "s:^char \*strndup://:" sys2.h.orig > sys2.h
}

src_compile() {     
	export CFLAGS="${CFLAGS}"
	try ./configure --host=${CHOST} --build=${CHOST} --prefix=/usr \
	--without-included-regex
	try make ${MAKEOPTS}
}

src_install() {
	try make prefix=${D}/usr install     
	rm -rf ${D}/usr/lib    
	dodir /bin
        cd ${D}/usr/bin
        mv date echo false pwd stty su true uname hostname ${D}/bin                      
	dodoc AUTHORS COPYING ChangeLog ChangeLog.0 \
	      NEWS README THANKS TODO
}



