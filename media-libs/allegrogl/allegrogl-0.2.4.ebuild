# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegrogl/allegrogl-0.2.4.ebuild,v 1.3 2004/11/17 23:35:48 eradicator Exp $

IUSE=""

inherit eutils

MY_PN="alleggl"
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="A library to mix OpenGL graphics with Allegro routines"
HOMEPAGE="http://${PN}.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"

DEPEND=">=media-libs/allegro-4.0.0"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-destdir.patch
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc howto.txt faq.txt quickstart.txt readme.txt todo.txt bugs.txt changelog
}
