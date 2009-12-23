# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/kccmp/kccmp-0.2-r2.ebuild,v 1.1 2009/12/23 01:26:55 mpagano Exp $

EAPI="1"
inherit qt4

DESCRIPTION="A simple tool for comparing two linux kernel .config files"
HOMEPAGE="http://stoopidsimple.com/kccmp/"
SRC_URI="http://stoopidsimple.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="qt4"
RDEPEND="x11-libs/qt-gui:4
		>=dev-libs/boost-1.34.1-r2"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# uncomment define for qt4 support
	sed -i 's/#DEFINES += KCCMP_QT_4/DEFINES += KCCMP_QT_4/' kccmp.pro \
		|| die "Could not uncomment define for qt support"
}

src_compile() {
	# Generates top-level Makefile
	eqmake4

	sed -i -e "/^CFLAGS =/s:-g:${CFLAGS}:" \
		Makefile || die "sed Makefile failed"

	emake || die "emake failed"
}

src_install() {
	dobin kccmp || die "installing binary failed"
	dodoc README
}
