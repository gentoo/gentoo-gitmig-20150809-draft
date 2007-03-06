# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-client/ggz-gtk-client-0.0.14.ebuild,v 1.2 2007/03/06 12:06:59 nyhm Exp $

inherit games-ggz

DESCRIPTION="The GTK+ client for GGZ Gaming Zone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="debug"

RDEPEND="~dev-games/ggz-client-libs-${PV}
	>=x11-libs/gtk+-2
	virtual/libintl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(package):$(PACKAGE):' doc/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	games-ggz_src_compile \
		--disable-gaim-plugin
}
