# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qtractor/qtractor-0.1.0.ebuild,v 1.2 2008/01/17 11:05:57 maekke Exp $

inherit eutils qt4

DESCRIPTION="Qtractor is an Audio/MIDI multi-track sequencer."
HOMEPAGE="http://qtractor.sourceforge.net/"
SRC_URI="mirror://sourceforge/qtractor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug libsamplerate mad vorbis sse"

DEPEND="$(qt4_min_version 4.1)
	media-libs/alsa-lib
	media-libs/libsndfile
	media-libs/ladspa-sdk
	media-sound/jack-audio-connection-kit
	mad? ( media-libs/libmad )
	libsamplerate? ( media-libs/libsamplerate )
	vorbis? ( media-libs/libvorbis )"

pkg_setup() {
	if ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror ""
		eerror "To be able to build ${CATEGORY}/${PN} with ALSA support you"
		eerror "need to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_compile() {
	econf \
		$(use_enable mad libmad) \
		$(use_enable libsamplerate) \
		$(use_enable vorbis libvorbis) \
		$(use_enable sse) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog TODO AUTHORS
}
