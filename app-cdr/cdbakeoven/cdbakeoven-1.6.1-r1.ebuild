# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbakeoven/cdbakeoven-1.6.1-r1.ebuild,v 1.3 2001/11/25 19:44:20 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.2
need-qt 2.3

DESCRIPTION="CDBakeOven, KDE CD Writing Software"
SRC_URI="http://prdownloads.sourceforge.net/cdbakeoven/cdbakeoven-generic-${PV}.tar.bz2"
HOMEPAGE="http://cdbakeoven.sourceforge.net"

S=${WORKDIR}/cdbakeoven-generic-${PV}

NEWDEPEND=">=kde-base/kdebase-2.2"

DEPEND="$DEPEND $NEWDEPEND"
RDEPEND="$RDEPEND $NEWDEPEND"

src_unpack() {

    base_src_unpack
    cd ${S}
    ln -s Makefile.dist Makefile.cvs
    kde-objprelink-patch

}

