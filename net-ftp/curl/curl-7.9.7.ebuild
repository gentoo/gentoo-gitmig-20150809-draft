# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-ftp/curl/curl-7.9.7.ebuild,v 1.6 2002/08/16 14:24:44 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Client that groks URLs"
SRC_URI="http://curl.haxx.se/download/${P}.tar.gz"
HOMEPAGE="http://curl.haxx.se"

DEPEND=">=sys-libs/pam-0.75 
	ssl? ( >=dev-libs/openssl-0.9.6a )"

SLOT="0"
LICENSE="MPL X11"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {

	local myconf
	use ssl \
		&& myconf="--with-ssl" \
		|| myconf="--without-ssl"

    cd ${S}
    econf ${myconf} || die
    emake || die

}

src_install () {
    cd ${S}
    make install DESTDIR=${D} || die
    dodoc LEGAL CHANGES README 
    dodoc docs/FEATURES docs/INSTALL docs/INTERNALS docs/LIBCURL 
    dodoc docs/MANUAL docs/FAQ docs/BUGS docs/CONTRIBUTE
}
