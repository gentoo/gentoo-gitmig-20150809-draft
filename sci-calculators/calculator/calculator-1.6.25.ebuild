# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/calculator/calculator-1.6.25.ebuild,v 1.3 2007/06/06 15:45:18 gustavoz Exp $

inherit fox

DESCRIPTION="Scientific calculator based on the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ppc ~ppc64 sparc ~x86"
IUSE=""

RDEPEND="~x11-libs/fox-${PV}"
