# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/calculator/calculator-1.5.4.ebuild,v 1.2 2005/06/23 03:34:03 ribosome Exp $

inherit fox

DESCRIPTION="Scientific calculator based on the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~alpha ~hppa ~ppc ~ppc64 ~sparc"
IUSE=""

RDEPEND="~x11-libs/fox-${PV}"
