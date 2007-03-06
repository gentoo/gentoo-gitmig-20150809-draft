# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-kde-client/ggz-kde-client-0.0.14.ebuild,v 1.2 2007/03/06 12:07:46 nyhm Exp $

inherit eutils kde-functions games-ggz

DESCRIPTION="The KDE client for GGZ Gaming Zone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="arts"

RDEPEND="~dev-games/ggz-client-libs-${PV}
	virtual/libintl
	net-misc/howl
	arts? ( kde-base/arts )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

need-kde 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-defines.patch
}

src_compile() {
	games-ggz_src_compile \
		$(use_with arts)
}
