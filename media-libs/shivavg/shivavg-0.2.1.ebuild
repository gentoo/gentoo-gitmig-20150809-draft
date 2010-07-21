# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/shivavg/shivavg-0.2.1.ebuild,v 1.1 2010/07/21 16:13:39 lu_zero Exp $

EAPI=2

inherit autotools

DESCRIPTION="ShivaVG is an open-source ANSI C implementation of the Khronos'
OpenVG specification for hardware-accelerated vector graphics API. It is built
entirely on top of OpenGL."
HOMEPAGE="http://shivavg.sourceforge.net"

MY_PN="ShivaVG"
MY_P="${MY_PN}-${PV}"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~arm ~amd64"
IUSE=""

RDEPEND="virtual/glu
         virtual/glut
		 virtual/opengl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e 's:LDFLAGS="$LDFLAGS :LIBS=":g' \
		configure.in
	eautoreconf
}

src_install() {
	emake DESTDIR=${D} install || die
}
