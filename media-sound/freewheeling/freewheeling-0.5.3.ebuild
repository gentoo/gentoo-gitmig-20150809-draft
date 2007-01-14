# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/freewheeling/freewheeling-0.5.3.ebuild,v 1.1 2007/01/14 01:38:36 matsuu Exp $

inherit eutils multilib

IUSE="fluidsynth"
MY_P="fweelin-${PV/_/}"

DESCRIPTION="A live looping instrument using SDL and jack."
HOMEPAGE="http://freewheeling.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

# don't keyword it stable on amd64 before talking to fvdpol@gentoo.org
KEYWORDS="~amd64 ~ppc ~x86"

# x11
DEPEND="x11-libs/libXt
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

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:/usr/local/lib/jack:/usr/$(get_libdir)/jack:" src/Makefile.{am,in} || die
}

src_compile() {
	econf $(use_enable fluidsynth) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog EVOLUTION NEWS README THANKS TUNING
	docinto examples; dodoc examples/*
}
