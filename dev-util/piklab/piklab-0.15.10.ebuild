# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/piklab/piklab-0.15.10.ebuild,v 1.1 2010/10/07 21:34:04 vapier Exp $

EAPI="2"

inherit qt4-r2 cmake-utils

DESCRIPTION="command-line programmer and debugger for PIC and dsPIC microcontrollers"
HOMEPAGE="http://piklab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz -> ${P}.tar.bz2"

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

MYCMAKEARGS="-DQT_ONLY=1"

src_prepare() {
	sed -i \
		-e "/\<share.doc.piklab\>/s:/piklab:/${PF}:" \
		CMakeLists.txt
	default
}
