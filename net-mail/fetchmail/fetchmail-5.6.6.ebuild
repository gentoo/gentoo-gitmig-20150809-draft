# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-5.6.6.ebuild,v 1.1 2001/02/19 20:34:38 ryan Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="fetchmail"
SRC_URI="http://www.tuxedo.org/~esr/fetchmail/"${A}
HOMEPAGE="http://www.tuxedo.org/~esr/fetchmail/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/openssl-0.9.6"

src_compile() {
    export CFLAGS="$CFLAGS -I/usr/include/openssl" \

    try ./configure --prefix=/usr --host=${CHOST} \
	--with-ssl --with-catgets --enable-RPA --enable-NTLN \
	--enable-SDPS
    try make
}


src_install() {
    try make DESTDIR=${D} install
    dodoc FAQ FEATURES ABOUT-NLS NEWS NOTES README README.NTLM \
          TODO COPYING MANIFEST
    docinto html
    dodoc *.html
    docinto contrib
    dodoc contrib/*
}




