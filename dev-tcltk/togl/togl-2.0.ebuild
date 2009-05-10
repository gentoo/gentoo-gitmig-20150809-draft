# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/togl/togl-2.0.ebuild,v 1.1 2009/05/10 12:09:14 mescalinum Exp $

EAPI="2"

MY_P="Togl${PV}"

DESCRIPTION="A Tcl/Tk widget for OpenGL rendering"
HOMEPAGE="http://togl.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +threads"

RDEPEND="virtual/opengl
	dev-lang/tk
	dev-lang/tcl"
DEPEND="${RDEPEND}"

# tests directory is missing
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf $(use_enable debug symbols) $(use_enable threads)
}

src_install() {
	make install DESTDIR="${D}"
}
