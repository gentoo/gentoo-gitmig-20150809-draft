# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lxbank/lxbank-0.1.8.ebuild,v 1.2 2004/02/09 23:06:33 hanno Exp $

DESCRIPTION="Graphical HBCI online banking tool"
HOMEPAGE="http://lxbank.sourceforge.net/"
SRC_URI="mirror://sourceforge/lxbank/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=net-libs/openhbci-0.9.11
	>=x11-libs/qt-3.0.5
	>=sys-libs/libchipcard-0.9
	app-misc/ktoblzcheck"

src_compile() {
	econf --with-qt-includes=/usr/qt/3/include/ || die
	emake || die
}

src_install() {
	einstall || die
}
