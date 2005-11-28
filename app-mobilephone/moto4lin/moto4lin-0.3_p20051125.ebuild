# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/moto4lin/moto4lin-0.3_p20051125.ebuild,v 1.2 2005/11/28 11:33:26 flameeyes Exp $

DESCRIPTION="Moto4lin is file manager and seem editor for Motorola P2K phones"
HOMEPAGE="http://moto4lin.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libusb
		x11-libs/qt"

src_compile() {
	# We need this addwrite since the uic program tries to create
	# locks in there :/
	addwrite "${ROOT}/usr/qt/3/etc/settings"

	qmake
	make || die "make failed"
}

src_install() {
	make INSTALL_ROOT=${D} install || die "make install failed"
	dodoc Changelog README
}
