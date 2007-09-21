# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/glaxium/glaxium-0.5.ebuild,v 1.17 2007/09/21 13:48:27 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="OpenGL-based space-ship shoot-em-up style game"
HOMEPAGE="http://xhosxe.free.fr/glaxium/"
SRC_URI="http://xhosxe.free.fr/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	virtual/opengl
	virtual/glu
	virtual/glut
	media-libs/libpng"

S=${WORKDIR}/${PN}_${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	if has_version x11-drivers/nvidia-drivers ; then
		epatch "${FILESDIR}"/${P}-glx.patch
	fi
	epatch \
		"${FILESDIR}"/${PV}-rc.patch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt CHANGES.txt
	prepgamesdirs
}
