# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-txt-client/ggz-txt-client-0.0.14.ebuild,v 1.2 2007/03/06 12:06:13 nyhm Exp $

inherit games-ggz

DESCRIPTION="The text-based client for GGZ Gaming Zone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="debug"

RDEPEND="~dev-games/ggz-client-libs-${PV}
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"
