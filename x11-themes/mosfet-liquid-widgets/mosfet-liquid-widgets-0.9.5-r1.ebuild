# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mosfet-liquid-widgets/mosfet-liquid-widgets-0.9.5-r1.ebuild,v 1.1 2002/08/24 18:36:14 danarmak Exp $
inherit kde-base

need-kde 3

S=${WORKDIR}/mosfet-liquid${PV}
DESCRIPTION="Mosfet's High-Permormance Liquid Widgets and Style for KDE 3.x"
SRC_URI="http://www.mosfet.org/mosfet-liquid${PV}.tar.gz"
HOMEPAGE="http://www.mosfet.org/liquid.html"
LICENSE="BSD"

KEYWORDS="x86 ppc"

newdepend ">=kde-base/kdebase-3.0"


src_install() {

    kde_src_install all
    
    # replace ksplash image
    dodir $KDEDIR/share/apps
    mv $D/$PREFIX/share/apps/ksplash $D/$KDEDIR/share/apps

}

