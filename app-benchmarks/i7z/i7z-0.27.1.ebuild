# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/i7z/i7z-0.27.1.ebuild,v 1.2 2012/06/04 09:52:49 ago Exp $

EAPI=4

inherit eutils flag-o-matic qt4-r2 toolchain-funcs

DESCRIPTION="A better i7 (and now i3, i5) reporting tool for Linux"
HOMEPAGE="http://code.google.com/p/i7z/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="X"

RDEPEND="
	sys-libs/ncurses
	X? ( x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}"

src_prepare() {
# -O0 is need because we get segf on higher optimizations
	replace-flags -O? -O0
	epatch "${FILESDIR}"/${P}-gentoo.patch
	tc-export CC
}

src_compile() {
	default
	if use X; then
		cd GUI
		eqmake4 ${PN}_GUI.pro
		emake clean && emake
	fi
}

src_install() {
	emake DESTDIR="${ED}" install
	if use X; then
		dosbin GUI/i7z_GUI
	fi
	dodoc put_cores_o*line.sh MAKEDEV-cpuid-msr
}
