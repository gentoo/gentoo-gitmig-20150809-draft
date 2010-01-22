# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.14.1.ebuild,v 1.15 2010/01/22 22:11:22 abcd Exp $

inherit games-ggz

DESCRIPTION="The client libraries for GGZ Gaming Zone"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-linux ~x86-linux"

IUSE="debug"

RDEPEND="~dev-games/libggz-${PV}
	dev-libs/expat
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"
PATCHES=( "${FILESDIR}"/${P}-destdir.patch )
