# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/construo/construo-0.2.2.ebuild,v 1.10 2006/02/16 20:21:11 tupone Exp $

inherit games

DESCRIPTION="2d construction toy with objects that react on physical forces"
HOMEPAGE="http://www.nongnu.org/construo/"
SRC_URI="http://freesoftware.fsf.org/download/construo/construo.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="|| (
				(
					x11-libs/libSM
					x11-libs/libXxf86vm
				)
				virtual/x11
			)
		sys-libs/zlib"
DEPEND="${RDEPEND}
		||  (
				(
					x11-proto/xf86vidmodeproto
					x11-libs/libXt
				)
				virtual/x11
			)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:<math.h>:<cmath>:g' vector.cxx \
		|| die "sed failed"

}

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		bindir="${GAMES_BINDIR}" install \
		|| die "make install failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
