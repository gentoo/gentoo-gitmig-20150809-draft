# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/lpairs/lpairs-1.0.3.ebuild,v 1.2 2008/01/01 16:55:32 nyhm Exp $

inherit games

DESCRIPTION="A classical memory game"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LPairs"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="media-libs/libsdl
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:$localedir:/usr/share/locale:' \
		-e 's:$(localedir):/usr/share/locale:' \
		configure po/Makefile.in.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS TODO ChangeLog
	prepgamesdirs
}
