# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/freewheeling/freewheeling-0.5_pre4.ebuild,v 1.1 2005/07/14 20:57:08 fvdpol Exp $

IUSE="fluidsynth"
MY_P="fweelin-0.5pre4"

DESCRIPTION="A live looping instrument using SDL and jack."
HOMEPAGE="http://freewheeling.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.bz2"
RESTRICT=""

LICENSE="GPL-2"
SLOT="0"

# don't keyword it stable on amd64 before talking to fvdpol@gentoo.org
KEYWORDS="~x86 ~amd64"

DEPEND="
	virtual/libc
	virtual/jack
	>=media-libs/libsdl-1.2.4
	dev-libs/libxml2
	media-libs/libvorbis
	fluidsynth?         ( media-sound/fluidsynth )
	media-libs/sdl-gfx
	>=media-libs/sdl-ttf-2.0.0"

src_compile() {
	cd ${WORKDIR}/${MY_P} && \
	econf || die
	emake || die
}

src_install() {
	cd ${WORKDIR}/${MY_P} && \
	einstall || die
	dodoc COPYING README TODO EVOLUTION THANKS TUNING NEWS AUTHORS
}
