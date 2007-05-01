# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-kde-client/ggz-kde-client-0.0.14.ebuild,v 1.3 2007/05/01 16:21:47 nyhm Exp $

inherit autotools eutils kde-functions games-ggz

DESCRIPTION="The KDE client for GGZ Gaming Zone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="arts avahi"

RDEPEND="~dev-games/ggz-client-libs-${PV}
	virtual/libintl
	arts? ( kde-base/arts )
	avahi? ( net-dns/avahi )
	!avahi? ( net-misc/howl )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

need-kde 3

pkg_setup() {
	if use avahi && ! built_with_use net-dns/avahi howl-compat ; then
		die "Please build net-dns/avahi with USE=howl-compat"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-defines.patch \
		"${FILESDIR}"/${P}-howl.patch
	eautoconf
}

src_compile() {
	games-ggz_src_compile \
		$(use_with arts)
}
