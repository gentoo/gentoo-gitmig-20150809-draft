# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/moto4lin/moto4lin-0.3_p20051125-r1.ebuild,v 1.1 2009/06/20 21:48:07 mrness Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Moto4lin is file manager and seem editor for Motorola P2K phones"
HOMEPAGE="http://moto4lin.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="dev-libs/libusb:0
	=x11-libs/qt-3*"

src_compile() {
	# We need this addwrite since the uic program tries to create
	# locks in there :/
	addwrite "/usr/qt/3/etc/settings"

	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake
	emake \
		CC="$(tc-getCC) ${CFLAGS}" \
		CXX="$(tc-getCXX) ${CXXFLAGS}" \
		LINK="$(tc-getCXX)" \
		LFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	make INSTALL_ROOT="${D}" install || die "make install failed"
	dodoc Changelog README
}
