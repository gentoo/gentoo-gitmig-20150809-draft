
# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sh-utils/sh-utils-2.0j-r2.ebuild,v 1.1 2001/02/07 15:51:28 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Your standard GNU shell utilities"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"

DEPEND="virtual/glibc
        >=sys-devel/gettext-0.10.35-r2"

DEPEND="virtual/glibc"

src_unpack() {
  unpack ${A}
  cd ${S}/src
  cp sys2.h sys2.h.orig
  sed -e "s:^char \*strndup://:" sys2.h.orig > sys2.h
}

src_compile() {

	try CFLAGS=\"${CFLAGS}\" ./configure --host=${CHOST} --build=${CHOST} \
                --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info \
	        --without-included-regex
	try make ${MAKEOPTS}
}

src_install() {

	try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
	rm -rf ${D}/usr/lib
	dodir /bin
        cd ${D}/usr/bin
	# We must use hostname from net-base
	rm hostname
        mv date echo false pwd stty su true uname ${D}/bin

        cd ${S}
	dodoc AUTHORS COPYING ChangeLog ChangeLog.0 \
	      NEWS README THANKS TODO
}



