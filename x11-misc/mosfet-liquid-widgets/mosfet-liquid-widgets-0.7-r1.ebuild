# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mosfet-liquid-widgets/mosfet-liquid-widgets-0.7-r1.ebuild,v 1.1 2001/11/16 12:50:42 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.2

PN=mosfet-liquid
S=${WORKDIR}/${PN}${PV}
DESCRIPTION="Mosfet's High-Permormance Liquid Widgets and Style for KDE2.2+"
SRC_URI="http://www.mosfet.org/${PN}${PV}.tar.gz"

HOMEPAGE="http://www.mosfet.org/liquid.html"

DEPEND="$DEPEND >=kde-base/kdebase-2.2"
RDEPEND="$RDEPEND >=kde-base/kdebase-2.2"

src_unpack() {
    base_src_unpack all
    cd ${S}/kwin-engine
    cp Makefile.am 1
    sed -e 's:-I$(kde_includes)/kwin:-I$(kde_includes)/kwin -I/usr/include/kwin:' \
	-e 's:$(kde_libraries)/kwin.la:/usr/lib/kwin.la:' 1 > Makefile.am
    rm 1
}

src_compile() {
    make -f Makefile.cvs
    kde_src_compile
}

