# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/construo/construo-0.2.2.ebuild,v 1.14 2008/05/01 13:11:32 nyhm Exp $

inherit eutils games

DESCRIPTION="2d construction toy with objects that react on physical forces"
HOMEPAGE="http://www.nongnu.org/construo/"
SRC_URI="http://freesoftware.fsf.org/download/construo/construo.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libSM
	x11-libs/libXxf86vm
	x11-libs/libXt"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		bindir="${GAMES_BINDIR}" install \
		|| die "emake install failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
