# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mosfet-liquid-widgets/mosfet-liquid-widgets-0.6.ebuild,v 1.1 2001/10/05 11:46:29 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

PN=mosfet-liquid
S=${WORKDIR}/${PN}${PV}
DESCRIPTION="Mosfet's High-Permormance Liquid Widgets and Style for KDE2.2+"
SRC_URI="http://www.mosfet.org/${PN}${PV}.tar.gz"

HOMEPAGE="http://www.mosfet.org/liquid.html"

DEPEND="$DEPEND >=kde-base/kdelibs-2.2"
RDEPEND="$RDEPEND >=kde-base/kdelibs-2.2"

src_compile() {
    make -f Makefile.cvs
    kde_src_compile
}

pkg_postinst() {
    echo "NOTE: if you had KDE running with these widgets already enabled,
you have a spectacular crash. Enjoy!"
}




