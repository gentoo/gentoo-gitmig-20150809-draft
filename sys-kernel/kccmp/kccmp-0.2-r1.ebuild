# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/kccmp/kccmp-0.2-r1.ebuild,v 1.4 2008/04/27 01:46:25 mpagano Exp $

EAPI="1"
inherit qt3 qt4

DESCRIPTION="A simple tool for comparing two linux kernel .config files"
HOMEPAGE="http://stoopidsimple.com/kccmp/"
SRC_URI="http://stoopidsimple.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="qt4"
RDEPEND="!qt4? ( >=x11-libs/qt-3.3.8-r4:3 )
	qt4? ( || ( ( x11-libs/qt-core:4
			x11-libs/qt-gui:4 )
			>=x11-libs/qt-4.3:4 ) )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use qt4 ; then
		#uncomment define for qt4 support
		sed -i 's/#DEFINES += KCCMP_QT_4/DEFINES += KCCMP_QT_4/' kccmp.pro \
			|| die "Could not uncomment define for qt support"
	else
		#do not link to boost libs when not using qt4
		sed -i 's/LIBS/#LIBS/' kccmp.pro \
			|| die "Could not remove linking to boost library"

		# fix for bug #218490, if no qt4, add additional include directive
		epatch "${FILESDIR}"/${P}-${PR}-no-qt4-missing-include.patch
	fi
}

src_compile() {
	# Generates top-level Makefile
	if use qt4 ; then
		eqmake4
	else
		eqmake3
	fi

	sed -i -e "/^CFLAGS =/s:-g:${CFLAGS}:" \
		Makefile || die "sed Makefile failed"

	emake || die "emake failed"
}

src_install() {
	dobin kccmp || die "installing binary failed"
	dodoc README
}
