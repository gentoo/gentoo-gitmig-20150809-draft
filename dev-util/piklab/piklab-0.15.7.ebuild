# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/piklab/piklab-0.15.7.ebuild,v 1.4 2011/06/03 15:02:45 jlec Exp $

EAPI=2
inherit qt4-r2

DESCRIPTION="CLI programmer and debugger for PIC and dsPIC microcontrollers"
HOMEPAGE="http://piklab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/qt-gui:4
	x11-libs/qt-qt3support:4
	sys-libs/ncurses
	sys-libs/readline
	virtual/libusb:0"
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
