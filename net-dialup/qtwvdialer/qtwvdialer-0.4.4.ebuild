# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.4.4.ebuild,v 1.5 2010/01/09 15:46:51 ssuominen Exp $

inherit eutils qt3

DESCRIPTION="Qt3 frontend for wvdial"
SRC_URI="http://www.mtoussaint.de/${P}.tgz"
HOMEPAGE="http://www.mtoussaint.de/qtwvdialer.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

COMMON_DEPEND="=x11-libs/qt-3*"
RDEPEND="${COMMON_DEPEND}
	net-dialup/wvdial"
DEPEND="${COMMON_DEPEND}
	>=dev-util/tmake-1.6
	sys-apps/which"

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
