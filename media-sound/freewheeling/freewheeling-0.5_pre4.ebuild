# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/freewheeling/freewheeling-0.5_pre4.ebuild,v 1.6 2006/10/02 06:31:22 flameeyes Exp $

inherit eutils

IUSE="fluidsynth"
MY_P="fweelin-${PV/_/}"

DESCRIPTION="A live looping instrument using SDL and jack."
HOMEPAGE="http://freewheeling.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.bz2"
RESTRICT=""

LICENSE="GPL-2"
SLOT="0"

# don't keyword it stable on amd64 before talking to fvdpol@gentoo.org
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="media-sound/jack-audio-connection-kit
	>=media-libs/libsdl-1.2.4
	dev-libs/libxml2
	media-libs/libvorbis
	fluidsynth? ( media-sound/fluidsynth )
	media-libs/sdl-gfx
	>=media-libs/sdl-ttf-2.0.0"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc41.patch"
}

src_install() {
	einstall || die
	dodoc README TODO EVOLUTION THANKS TUNING NEWS AUTHORS
}
