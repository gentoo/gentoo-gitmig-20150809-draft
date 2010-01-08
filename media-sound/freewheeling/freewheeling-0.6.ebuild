# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/freewheeling/freewheeling-0.6.ebuild,v 1.1 2010/01/08 13:57:32 patrick Exp $

inherit multilib

MY_P="fweelin-${PV/_/}"

DESCRIPTION="A live looping instrument using SDL and jack."
HOMEPAGE="http://freewheeling.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="fluidsynth"

RDEPEND="x11-libs/libXt
	net-libs/gnutls
	media-libs/freetype
	media-libs/sdl-gfx
	>=media-libs/sdl-ttf-2.0.0
	dev-libs/libxml2
	media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	fluidsynth? ( media-sound/fluidsynth )
	media-libs/libvorbis
	media-libs/libsndfile"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:/usr/local/lib/jack:/usr/$(get_libdir)/jack:" src/Makefile.{am,in}
}

src_compile() {
	econf $(use_enable fluidsynth)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS TUNING
	docinto examples
	dodoc examples/*
}
