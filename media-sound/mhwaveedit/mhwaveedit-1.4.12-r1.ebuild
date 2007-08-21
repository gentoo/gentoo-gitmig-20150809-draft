# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mhwaveedit/mhwaveedit-1.4.12-r1.ebuild,v 1.1 2007/08/21 09:47:18 aballier Exp $

inherit eutils autotools

IUSE="alsa arts esd jack ladspa libsamplerate nls oss portaudio sdl sndfile sox"

DESCRIPTION="GTK2 Sound file editor (wav, and a few others.)"
HOMEPAGE="https://gna.org/projects/mhwaveedit/"
SRC_URI="http://download.gna.org/mhwaveedit/${P}.tar.bz2
	mirror://gentoo/${P}-m4-1.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=x11-libs/gtk+-2
	sndfile? ( >=media-libs/libsndfile-1.0.10 )
	sdl? ( >=media-libs/libsdl-1.2.3 )
	alsa? ( media-libs/alsa-lib )
	portaudio? ( >=media-libs/portaudio-18 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.98.0 )
	esd? ( >=media-sound/esound-0.2.0 )
	libsamplerate? ( media-libs/libsamplerate )
	ladspa? ( media-libs/ladspa-sdk )
	sox? ( media-sound/sox )
	arts? ( >=kde-base/arts-3.4.1 )"

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-pkgconfig_init.patch"
	cp "${WORKDIR}"/m4/* m4/
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_with sndfile libsndfile) \
		$(use_with libsamplerate) \
		$(use_with portaudio) \
		$(use_with sdl) \
		$(use_with alsa alsalib) \
		$(use_with oss) \
		$(use_with jack) \
		$(use_with esd esound) \
		$(use_with arts) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS ChangeLog HACKING NEWS README TODO

	newicon src/icon.xpm ${PN}.xpm
	make_desktop_entry mhwaveedit mhWaveEdit ${PN}.xpm AudioVideo

}
