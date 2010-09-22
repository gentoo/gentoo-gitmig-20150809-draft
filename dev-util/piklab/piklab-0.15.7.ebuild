# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/piklab/piklab-0.15.7.ebuild,v 1.3 2010/09/22 18:36:43 ssuominen Exp $

EAPI=2
inherit qt4-r2

DESCRIPTION="command-line programmer and debugger for PIC and dsPIC microcontrollers"
HOMEPAGE="http://piklab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-qt3support:4
	virtual/libusb:0
	sys-libs/ncurses
	sys-libs/readline"
DEPEND="${RDEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	eqmake4 piklab-prog.pro
}

src_install() {
	local bin
	for bin in coff hex prog; do
		dobin src/piklab-${bin}/piklab-${bin} || die
	done

	doman man/piklab-{hex,prog}.1 || die
	dodoc README TODO
}
