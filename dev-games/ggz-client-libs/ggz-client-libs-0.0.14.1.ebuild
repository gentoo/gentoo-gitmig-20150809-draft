# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.14.1.ebuild,v 1.1 2008/02/18 16:10:50 nyhm Exp $

inherit games-ggz

DESCRIPTION="The client libraries for GGZ Gaming Zone"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug"

RDEPEND="~dev-games/libggz-${PV}
	dev-libs/expat
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"
