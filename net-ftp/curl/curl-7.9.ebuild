# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <ps@gnuos.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/curl/curl-7.9.ebuild,v 1.1 2001/10/21 18:31:06 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Client that groks URLs"
SRC_URI="http://curl.haxx.se/download/${P}.tar.gz"
HOMEPAGE="http://curl.haxx.de"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.75
	>=dev-libs/openssl-0.9.6a"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --with-ssl
    try make

}

src_install () {

    cd ${S}
    try make install DESTDIR=${D}
    dodoc LEGAL CHANGES README 
    dodoc docs/FEATURES docs/INSTALL docs/INTERNALS docs/LIBCURL 
    dodoc docs/MANUAL docs/FAQ docs/BUGS docs/CONTRIBUTE
}
