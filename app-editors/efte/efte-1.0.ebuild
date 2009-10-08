# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/efte/efte-1.0.ebuild,v 1.2 2009/10/08 16:45:30 hanno Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="A fast text editor supporting folding, syntax highlighting, etc."
HOMEPAGE="http://efte.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gpm X"

RDEPEND="sys-libs/ncurses
	gpm? ( sys-libs/gpm )
	X? (
		x11-libs/libXpm
		x11-libs/libXdmcp
		x11-libs/libXau
		media-fonts/font-misc-misc
	)"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs="
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_GPM=$(use gpm && echo ON || echo OFF) \
		-DBUILD_X=$(use X && echo ON || echo OFF)"
	cmake-utils_src_configure
}
