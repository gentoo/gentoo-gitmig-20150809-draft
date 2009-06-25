# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-kde-client/ggz-kde-client-0.0.14.1.ebuild,v 1.7 2009/06/25 20:56:53 mr_bones_ Exp $

EAPI=2
inherit autotools eutils kde-functions games-ggz

DESCRIPTION="The KDE client for GGZ Gaming Zone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="~dev-games/ggz-client-libs-${PV}
	virtual/libintl
	net-dns/avahi[howl-compat]"
DEPEND="${RDEPEND}
	sys-devel/gettext"

need-kde 3

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-defines.patch \
		"${FILESDIR}"/${P}-howl.patch
	eautoconf
}

src_compile() {
	games-ggz_src_compile --without-arts
}
