# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/piklab/piklab-0.15.10.ebuild,v 1.2 2011/06/03 15:02:45 jlec Exp $

EAPI=4

inherit qt4-r2 cmake-utils

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

MYCMAKEARGS="-DQT_ONLY=1"

PATCHES=( "${FILESDIR}"/${P}-gcc46.patch )

src_prepare() {
	sed -i \
		-e "/\<share.doc.piklab\>/s:/piklab:/${PF}:" \
		CMakeLists.txt
	base_src_prepare
}
