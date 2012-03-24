# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/i7z/i7z-0.27-r1.ebuild,v 1.3 2012/03/24 17:18:53 phajdan.jr Exp $

EAPI="4"

inherit eutils flag-o-matic qt4-r2 toolchain-funcs

DESCRIPTION="A better i7 (and now i3, i5) reporting tool for Linux"
HOMEPAGE="http://code.google.com/p/i7z/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ~amd64-linux ~x86-linux"
IUSE="X"

RDEPEND="
	sys-libs/ncurses
	X? ( x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	epatch "${FILESDIR}"/${P}-cpuid.patch
	tc-export CC
}

src_compile() {
	default
	if use X; then
		append-cxxflags -fno-inline-small-functions -fno-caller-saves
		cd GUI
		eqmake4 GUI.pro
		emake
	fi
}

src_install() {
	emake DESTDIR="${ED}" install
	if use X; then
		newsbin GUI/GUI i7z_GUI
	fi
	dodoc put_cores_o*line.sh MAKEDEV-cpuid-msr
}
