# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libvisual-projectm/libvisual-projectm-1.0.ebuild,v 1.1 2007/10/23 19:48:24 drac Exp $

inherit toolchain-funcs

MY_P=projectM-libvisual-${PV}

DESCRIPTION="A libvisual graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/libsdl
	=media-libs/libvisual-0.4*
	>=media-libs/libprojectm-1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/cmake"

S="${WORKDIR}"/${MY_P}

src_compile() {
	cmake \
		-DCMAKE_VERBOSE_MAKEFILE="ON" \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		-DCMAKE_C_COMPILER="$(type -P $(tc-getCC))" \
		-DCMAKE_CXX_COMPILER="$(type -P $(tc-getCXX))" \
		-DCMAKE_C_FLAGS="${CFLAGS}" \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
		-DCMAKE_LD_FLAGS="${LDFLAGS}" \
		. || die "cmake failed."

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog
}
