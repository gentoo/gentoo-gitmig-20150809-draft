# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/v4l-utils/v4l-utils-0.8.1.ebuild,v 1.1 2010/10/23 14:52:19 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs qt4-r2

DESCRIPTION="Separate utilities ebuild from upstream v4l-utils package"
HOMEPAGE="http://git.linuxtv.org/v4l-utils.git"
SRC_URI="http://linuxtv.org/downloads/v4l-utils/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

RDEPEND=">=media-libs/libv4l-${PV}
	qt4? ( x11-libs/qt-gui:4 )
	!media-tv/v4l2-ctl
	!media-tv/ivtv-utils"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}/utils

src_prepare() {
	epatch "${FILESDIR}"/${P}.patch
	use qt4 || sed -i -e 's:which $$QMAKE:which dISaBlEd:' Makefile
}

src_configure() {
	tc-export CC CXX
	if use qt4; then
		cd qv4l2
		eqmake4 qv4l2.pro
	fi
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die

	if use qt4; then
		doicon qv4l2/qv4l2.png
		make_desktop_entry qv4l2 "V42L Test Bench" qv4l2
	fi

	dodoc ../README
	newdoc libv4l2util/TODO TODO.libv4l2util
	newdoc xc3028-firmware/README README.xc3028-firmware
}
