# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.3.1.ebuild,v 1.1 2000/11/26 12:52:15 achim Exp $

S=${WORKDIR}/QtWvDialer-${PV}
DESCRIPTION="QT Frontend for wvdial"
SRC_URI="http://private.addcom.de/toussaint/${P}.tgz"
HOMEPAGE="http://private.addcom.de/toussaint/qtwvdialer.html"

DEPEND=">=kde-base/qt-x11-2.2.1
	>=dev-util/tmake-1.6"

src_compile() {

    cd ${S}
    export TMAKEPATH="/usr/lib/tmake/linux-g++"
    cp configure configure.orig
    sed -e "s:TMAKEPATH/\.\./\.\./bin/tmake:TMAKEPATH/../../../bin/tmake:" \
	configure.orig > configure
    try ./configure
    try make

}

src_install () {

    cd ${S}
    insinto /usr/X11R6
    dobin bin/qtwvdialer
    dodoc AUTHORS CHANGELOG COPYING README

}

