# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/litestream/litestream-1.2.ebuild,v 1.7 2004/11/23 05:52:54 eradicator Exp $

IUSE=""

inherit eutils flag-o-matic

DESCRIPTION="Litstream is a lightweight and robust shoutcast-compatible streaming mp3 server."
HOMEPAGE="http://www.litestream.org/"
SRC_URI="http://litestream.org/litestream/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~ppc x86"

DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/vargs.h ${S}/include

	cd ${S}
	epatch ${FILESDIR}/${P}-Makefile.patch

	append-flags "-DNO_VARARGS"
	sed -i "s/CFLAGS = /CFLAGS = ${CFLAGS} /g" Makefile
}

src_compile() {
	emake all || die
}

src_install() {
	dobin litestream literestream
	newbin source litestream-source
	newbin server litestream-server
	newbin client litestream-client

	dodoc ABOUT ACKNOWLEDGEMENTS BUGS CHANGELOG CONTACT FILES MAKEITGO README
}
