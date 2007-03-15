# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-13.0.0.ebuild,v 1.2 2007/03/15 23:26:33 aballier Exp $

inherit flag-o-matic eutils autotools

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="alsa debug flac encode mad ogg libsamplerate ogg sndfile"

DEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	encode? ( media-sound/lame )
	flac? ( media-libs/flac )
	mad? ( media-libs/libmad )
	sndfile? ( media-libs/libsndfile )
	libsamplerate? ( media-libs/libsamplerate )
	ogg? ( media-libs/libvorbis	media-libs/libogg )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-flac113.patch"
	epatch "${FILESDIR}/${P}-oggautomagic.patch"
	AT_M4DIR="m4" eautoreconf
}

src_compile () {
	# Fixes wav segfaults. See Bug #35745.
	append-flags -fsigned-char

	econf $(use_enable alsa alsa-dsp) \
		$(use_with encode lame) \
		$(use_with mad) \
		$(use_enable debug) \
		$(use_with sndfile) \
		$(use_with flac) \
		$(use_with ogg oggvorbis) \
		$(use_with libsamplerate samplerate) \
		--enable-oss-dsp \
		--enable-fast-ulaw \
		--enable-fast-alaw \
		|| die "configure failed"

	#workaround for flac, it wants to include a damn config.h file
	touch src/config.h
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc NEWS ChangeLog README AUTHORS
}
