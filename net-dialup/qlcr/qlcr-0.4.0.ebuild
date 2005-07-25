# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qlcr/qlcr-0.4.0.ebuild,v 1.3 2005/07/25 15:57:20 caleb Exp $

inherit eutils kde-functions

DESCRIPTION="Qt based Least Cost Router for Germany"
HOMEPAGE="http://www.thepingofdeath.de/index.php"
SRC_URI="http://mesh.dl.sourceforge.net/sourceforge/qlcr/${P}-2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


DEPEND="$(qt_min_version 3.3)
	>=net-dialup/wvdial-1.54.0
	net-misc/ntp
	net-misc/wget"

src_compile() {
	cd src
	${QTDIR}/bin/qmake -o Makefile qlcr.pro || die "qmake failed."
	emake || die "Make failed."
}

src_install() {
	dobin bin/qlcr

	domenu qlcr.desktop
	doicon qlcr.png

	dodoc README TODO FAQ INSTALL CHANGELOG
	doman qlcr.1.gz
}

pkg_postinst() {
	einfo
	einfo "To use qlcr you should add the appropriate user to the dialout group."
	einfo
}
