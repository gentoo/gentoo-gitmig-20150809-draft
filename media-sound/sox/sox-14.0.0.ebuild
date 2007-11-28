# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-14.0.0.ebuild,v 1.8 2007/11/28 17:34:41 armin76 Exp $

inherit flag-o-matic eutils autotools

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="alsa ao debug ffmpeg flac encode ladspa mad libsamplerate ogg oss sndfile"

DEPEND="alsa? ( media-libs/alsa-lib )
	encode? ( media-sound/lame )
	flac? ( media-libs/flac )
	mad? ( media-libs/libmad )
	sndfile? ( media-libs/libsndfile )
	libsamplerate? ( media-libs/libsamplerate )
	ogg? ( media-libs/libvorbis	media-libs/libogg )
	ao? ( media-libs/libao )
	ffmpeg? ( media-video/ffmpeg )
	ladspa? ( media-libs/ladspa-sdk )"
# Fails to compile here ...
# amrnb? ( media-libs/amrnb )
# amrwb? ( media-libs/amrwb )

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Disable external gsm lib support until it installs properly the lib
	# Bug #192736
	epatch "${FILESDIR}/${P}-noexternalgsm.patch"
	AT_M4DIR="${S}/m4" eautoreconf
}

src_compile () {
	# Fixes wav segfaults. See Bug #35745.
	append-flags -fsigned-char

	econf $(use_enable alsa) \
		$(use_enable debug) \
		$(use_enable ao libao) \
		$(use_enable oss) \
		$(use_with encode lame) \
		$(use_with mad) \
		$(use_with sndfile) \
		$(use_with flac) \
		$(use_with ogg) \
		$(use_with libsamplerate samplerate) \
		$(use_with ffmpeg) \
		$(use_with ladspa) \
		--without-amr-wb \
		--without-amr-nb \
		--enable-fast-ulaw \
		--enable-fast-alaw \
		|| die "configure failed"

	#workaround for flac, it wants to include a damn config.h file
	touch src/config.h
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc NEWS ChangeLog README AUTHORS
}
