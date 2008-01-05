# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/geki3-KXL/geki3-KXL-1.0.3-r2.ebuild,v 1.1 2008/01/05 22:00:31 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="2D length scroll shooting game"
HOMEPAGE="http://kxl.hn.org/"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-games/KXL"
RDEPEND="${DEPEND}
	media-fonts/font-bitstream-75dpi"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f missing
	sed -i \
		-e '1i #include <string.h>' \
		-e "s:DATA_PATH \"/.score\":\"${GAMES_STATEDIR}/${PN}\":" \
		src/ranking.c \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-paths.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_STATEDIR}"
	newins data/.score ${PN} || die "newins failed"
	fperms g+w "${GAMES_STATEDIR}"/${PN}
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry geki3 Geki3
	dodoc ChangeLog README
	prepgamesdirs
}
