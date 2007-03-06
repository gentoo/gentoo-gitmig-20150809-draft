# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-kde-games/ggz-kde-games-0.0.14.ebuild,v 1.2 2007/03/06 12:08:11 nyhm Exp $

inherit kde-functions games-ggz

DESCRIPTION="The KDE versions of the games for GGZ Gaming Zone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="arts"

RDEPEND="~dev-games/ggz-client-libs-${PV}
	gnome-base/librsvg
	virtual/libintl
	arts? ( kde-base/arts )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

need-kde 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/^\/\//d' koenig/ai.c || die "sed failed"
}

src_compile() {
	games-ggz_src_compile \
		$(use_with arts)
}
