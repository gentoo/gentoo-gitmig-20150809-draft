# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-5.8.11.ebuild,v 1.2 2001/08/31 18:48:14 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="fetchmail"
SRC_URI="http://www.tuxedo.org/~esr/fetchmail/"${P}.tar.gz
HOMEPAGE="http://www.tuxedo.org/~esr/fetchmail/"

DEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.9.6 )
	nls? ( sys-devel/gettext )"

src_compile() {
    local myconf
    if [ "`use ssl`" ] ; then
       export CFLAGS="$CFLAGS -I/usr/include/openssl"
       myconf="--with-ssl"
    fi
    if [ -z "`use nls`" ] ; then
	myconf="$myconf --disable-nls"
    fi
    if [ "`use ipv6`" ] ; then
	myconf="$myconf --enable-inet6"
    fi
    try ./configure --prefix=/usr --host=${CHOST} \
        --mandir=/usr/share/man \
	--infodir=/usr/share/info \
	--enable-RPA --enable-NTLN \
	--enable-SDPS $myconf
    try make
}


src_install() {
    try make DESTDIR=${D} install
    dodoc FAQ FEATURES ABOUT-NLS NEWS NOTES README README.NTLM README.SSL \
          TODO COPYING MANIFEST
    docinto html
    dodoc *.html
    docinto contrib
    dodoc contrib/*
}
