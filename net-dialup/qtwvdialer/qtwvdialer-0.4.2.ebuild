# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.4.2.ebuild,v 1.1 2004/09/27 12:33:50 dragonheart Exp $

inherit kde-functions eutils

need-qt 3

S=${WORKDIR}/QtWvDialer-${PV}
DESCRIPTION="QT Frontend for wvdial"
SRC_URI="http://www.mtoussaint.de/${P}.tgz"
HOMEPAGE="http://www.mtoussaint.de/qtwvdialer.html"

DEPEND=">=dev-util/tmake-1.6
	sys-apps/which
	virtual/modutils
	>=sys-apps/sed-4"

RDEPEND="net-dialup/wvdial"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/g++configure.patch
	sed -i -e "s:^CXXFLAGS=:CXXFLAGS=${CFLAGS}:" src/Makefile
}

src_install () {
	dobin bin/qtwvdialer
	dodoc AUTHORS CHANGELOG COPYING README

}
