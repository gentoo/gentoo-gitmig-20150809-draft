# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.3.1-r2.ebuild,v 1.13 2004/07/14 23:06:35 agriffis Exp $

S=${WORKDIR}/QtWvDialer-${PV}
DESCRIPTION="QT Frontend for wvdial"
SRC_URI="http://www.mtoussaint.de/${P}.tgz"
HOMEPAGE="http://www.mtoussaint.de/qtwvdialer.html"

DEPEND="=x11-libs/qt-2*
	>=dev-util/tmake-1.6
	net-dialup/wvdial
	sys-apps/which
	virtual/modutils"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

src_compile() {

	cd ${S}
	export TMAKEPATH="/usr/lib/tmake/linux-g++"
	cp configure configure.orig
	sed -e "s:TMAKEPATH/\.\./\.\./bin/tmake:TMAKEPATH/../../../bin/tmake:" \
	configure.orig > configure
	./configure || die
	QTDIR=/usr/qt/2 make -e CFLAGS="$CFLAGS" || die

}

src_install () {

	insinto /usr
	dobin bin/qtwvdialer
	dodoc AUTHORS CHANGELOG COPYING README

}
