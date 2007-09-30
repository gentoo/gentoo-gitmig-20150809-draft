# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/goosnes/goosnes-0.5.2.ebuild,v 1.12 2007/09/30 22:10:55 mr_bones_ Exp $

inherit autotools eutils games

DESCRIPTION="A GTK+ frontend for Snes9X"
HOMEPAGE="http://bard.sytes.net/goosnes/"
SRC_URI="http://bard.sytes.net/debian/dists/unstable/main/source/${PN}_${PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2
	games-emulation/snes9x"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtk2.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
