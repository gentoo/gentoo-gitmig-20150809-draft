# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.4.2.ebuild,v 1.4 2005/08/12 17:06:03 dholm Exp $

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
KEYWORDS="~ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/g++configure.patch
}

src_compile() {
	econf && \
		sed -i -e "s:^CXXFLAGS *=:CXXFLAGS = ${CFLAGS}:" src/Makefile && \
		emake || die "compile failed"
}

src_install () {
	dobin bin/qtwvdialer
	dodoc AUTHORS CHANGELOG COPYING README

}
