# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mosfet-liquid-widgets/mosfet-liquid-widgets-0.9.5.ebuild,v 1.7 2003/02/13 17:43:39 vapier Exp $

inherit kde-base || die

need-kde 3

S=${WORKDIR}/mosfet-liquid${PV}
DESCRIPTION="Mosfet's High-Permormance Liquid Widgets and Style for KDE 3.x"
SRC_URI="http://www.mosfet.org/mosfet-liquid${PV}.tar.gz"
HOMEPAGE="http://www.mosfet.org/liquid.html"
LICENSE="BSD"

KEYWORDS="x86 ppc alpha"

newdepend ">=kde-base/kdebase-3.0"
