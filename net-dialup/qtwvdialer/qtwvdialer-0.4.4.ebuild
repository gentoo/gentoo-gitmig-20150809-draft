# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.4.4.ebuild,v 1.3 2008/12/14 12:59:20 mrness Exp $

inherit kde-functions eutils

DESCRIPTION="QT Frontend for wvdial"
SRC_URI="http://www.mtoussaint.de/${P}.tgz"
HOMEPAGE="http://www.mtoussaint.de/qtwvdialer.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-util/tmake-1.6
	sys-apps/which"
RDEPEND="net-dialup/wvdial"

need-qt 3

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
