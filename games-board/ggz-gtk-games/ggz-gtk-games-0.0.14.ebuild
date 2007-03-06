# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-games/ggz-gtk-games-0.0.14.ebuild,v 1.2 2007/03/06 12:07:22 nyhm Exp $

inherit games-ggz

DESCRIPTION="The GTK+ versions of the games for GGZ Gaming Zone"

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
