# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mosfet-liquid-widgets/mosfet-liquid-widgets-0.9.5.ebuild,v 1.2 2002/05/21 18:14:11 danarmak Exp $

inherit kde-base || die

need-kde 3

S=${WORKDIR}/mosfet-liquid${PV}
DESCRIPTION="Mosfet's High-Permormance Liquid Widgets and Style for KDE 3.x"
SRC_URI="http://www.mosfet.org/mosfet-liquid${PV}.tar.gz"
HOMEPAGE="http://www.mosfet.org/liquid.html"

newdepend ">=kde-base/kdebase-3.0"
