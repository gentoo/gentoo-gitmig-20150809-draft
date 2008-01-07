# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qlcr/qlcr-0.4.1-r1.ebuild,v 1.1 2008/01/07 14:22:28 mrness Exp $

inherit eutils kde-functions

DESCRIPTION="Qt based Least Cost Router for Germany"
HOMEPAGE="http://www.thepingofdeath.de/"
SRC_URI="mirror://sourceforge/qlcr/${P}-1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)
	>=net-dialup/wvdial-1.54.0
	net-misc/ntp
	net-misc/wget"
RDEPEND="${DEPEND}"

src_unpack() { 
	unpack ${A}

	cd "${S}"
	# use a different provider file since the original one is no longer available
	epatch "${FILESDIR}/${P}-providerfileurl.patch"
	# reduce font size to 8 pts
	sed --in-place "s:<pointsize>9:<pointsize>8:" ${S}/src/lcr.ui || die "sed failed"
}

src_compile() {
	cd src
	${QTDIR}/bin/qmake -o Makefile qlcr.pro || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin src/qlcr

	domenu qlcr.desktop
	doicon qlcr.png

	dodoc README TODO FAQ CHANGELOG
	gunzip qlcr.1.gz
	doman qlcr.1
}

pkg_postinst() {
	elog
	elog "To use qlcr you should add the appropriate user to the dialout group."
	elog
}
