# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.4.2.ebuild,v 1.7 2006/03/16 20:20:20 mrness Exp $

inherit kde-functions eutils

DESCRIPTION="QT Frontend for wvdial"
SRC_URI="http://www.mtoussaint.de/${P}.tgz"
HOMEPAGE="http://www.mtoussaint.de/qtwvdialer.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=dev-util/tmake-1.6
	sys-apps/which"
RDEPEND="net-dialup/wvdial"

need-qt 3

S="${WORKDIR}/QtWvDialer-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/g++configure.patch"
}

src_compile() {
	econf && \
		sed -i -e "s:^CXXFLAGS *=:CXXFLAGS = ${CFLAGS}:" src/Makefile && \
		emake || die "compile failed"
}

src_install () {
	dobin bin/qtwvdialer
	dodoc AUTHORS CHANGELOG README

}
