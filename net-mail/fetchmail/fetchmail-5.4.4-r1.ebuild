# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-5.4.4-r1.ebuild,v 1.3 2000/09/15 20:09:11 drobbins Exp $

P=fetchmail-5.4.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="fetchmail"
SRC_URI="http://www.tuxedo.org/~esr/fetchmail/"${A}
HOMEPAGE="http://www.tuxedo.org/~esr/fetchmail/"

src_compile() {
    cd ${S}
    export CFLAGS="$CFLAGS -I/usr/include/openssl" \

    try ./configure --prefix=/usr --host=${CHOST} \
	--with-ssl --with-catgets --enable-RPM --enable-NTLN \
	--enable-SDPS
    try make
}


src_install() {                 
  cd ${S}
  into /usr
  dobin fetchmail
  cp fetchmail.man fetchmail.1
  doman fetchmail.1
  dodoc COPYING FAQ FEATURES MANIFEST NEWS NOTES README* TODO 
  dodoc sample.rcfile
  docinto html
  dodoc *.html
  docinto contrib
  dodoc contrib/*
}


