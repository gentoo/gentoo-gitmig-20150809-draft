# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-ftp/curl/curl-7.9.7.ebuild,v 1.2 2002/07/11 06:30:46 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Client that groks URLs"
SRC_URI="http://curl.haxx.se/download/${P}.tar.gz"
HOMEPAGE="http://curl.haxx.se"

DEPEND=">=sys-libs/glibc-2.1.3 >=sys-libs/pam-0.75 ssl? ( >=dev-libs/openssl-0.9.6a )"

src_compile() {
	local myconf
	if [ "`use ssl`" ]
	then
		myconf="--with-ssl"
	else
		myconf="--without-ssl"
	fi
    cd ${S}
    ./configure --prefix=/usr --mandir=/usr/share/man $myconf || die
    emake || die

}

src_install () {
    cd ${S}
    make install DESTDIR=${D} || die
    dodoc LEGAL CHANGES README 
    dodoc docs/FEATURES docs/INSTALL docs/INTERNALS docs/LIBCURL 
    dodoc docs/MANUAL docs/FAQ docs/BUGS docs/CONTRIBUTE
}
