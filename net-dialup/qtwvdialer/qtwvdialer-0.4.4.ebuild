# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.4.4.ebuild,v 1.4 2009/12/28 16:53:44 ssuominen Exp $

inherit eutils qt3

DESCRIPTION="Qt3 frontend for wvdial"
SRC_URI="http://www.mtoussaint.de/${P}.tgz"
HOMEPAGE="http://www.mtoussaint.de/qtwvdialer.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="=x11-libs/qt-3*
	>=dev-util/tmake-1.6
	sys-apps/which"
RDEPEND="net-dialup/wvdial"

S="${WORKDIR}/QtWvDialer-${PV}"

src_compile() {
	eqmake3 QtWvDialer.pro
	emake || die "emake failed"
}

src_install () {
	dobin bin/qtwvdialer || die "failed to install bin file"
	dodoc AUTHORS CHANGELOG README
	emake install
}
