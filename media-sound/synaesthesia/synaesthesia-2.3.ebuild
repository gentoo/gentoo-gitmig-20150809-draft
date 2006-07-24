# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/synaesthesia/synaesthesia-2.3.ebuild,v 1.7 2006/07/24 00:21:59 ticho Exp $

inherit eutils

DESCRIPTION="a nice graphical accompaniment to music"
HOMEPAGE="http://www.logarithmic.net/pfh/synaesthesia"
SRC_URI="http://www.logarithmic.net/pfh-files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="sdl svga esd"

RDEPEND="|| ( ( x11-libs/libXext
				x11-libs/libSM )
			virtual/x11
		)
	esd? ( >=media-sound/esound-0.2.22 )
	sdl? ( >=media-libs/libsdl-1.2.0 )
	svga? ( >=media-libs/svgalib-1.4.3 )"

DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/CFLAGS=/s:-O4:${CFLAGS}:" \
		-e "/CXXFLAGS=/s:-O4:${CXXFLAGS}:" \
		configure
	sed -i 's:void inline:inline void:' syna.h
}

src_install() {
	dobin synaesthesia || die
	dodoc README
}
