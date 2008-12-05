# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/adie/adie-1.6.34.ebuild,v 1.4 2008/12/05 10:04:37 armin76 Exp $

inherit fox

DESCRIPTION="Text editor based on the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="~x11-libs/fox-${PV}"

RDEPEND="${DEPEND}"
