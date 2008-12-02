# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/calculator/calculator-1.6.34.ebuild,v 1.2 2008/12/02 06:08:34 jer Exp $

inherit fox

DESCRIPTION="Scientific calculator based on the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="~x11-libs/fox-${PV}"
