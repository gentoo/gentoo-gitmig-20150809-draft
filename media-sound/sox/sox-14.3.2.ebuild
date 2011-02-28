# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-14.3.2.ebuild,v 1.1 2011/02/28 10:48:23 aballier Exp $

EAPI=2
inherit flag-o-matic

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="alsa amr ao debug encode ffmpeg flac id3tag ladspa mad ogg oss png pulseaudio sndfile wavpack"

# libtool required for libltdl
RDEPEND="sys-devel/libtool
	alsa? ( media-libs/alsa-lib )
	amr? ( media-libs/opencore-amr )
	encode? ( media-sound/lame )
	flac? ( media-libs/flac )
	mad? ( media-libs/libmad )
	sndfile? ( media-libs/libsndfile )
	ogg? ( media-libs/libvorbis	media-libs/libogg )
	ao? ( media-libs/libao )
	ffmpeg? ( >=media-video/ffmpeg-0.5 )
	ladspa? ( media-libs/ladspa-sdk )
	>=media-sound/gsm-1.0.12-r1
	id3tag? ( media-libs/libid3tag )
	png? ( media-libs/libpng sys-libs/zlib )
	pulseaudio? ( media-sound/pulseaudio )
	wavpack? ( media-sound/wavpack )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	# Fixes wav segfaults. See Bug #35745.
	append-flags -fsigned-char

	econf \
		$(use_with alsa) \
		$(use_enable debug) \
		$(use_with ao) \
		$(use_with oss) \
		$(use_with encode lame) \
		$(use_with mad) \
		$(use_with sndfile) \
		$(use_with flac) \
		$(use_with ogg oggvorbis) \
		$(use_with ffmpeg) \
		$(use_with ladspa) \
		$(use_with id3tag) \
		$(use_with amr amrwb) \
		$(use_with amr amrnb) \
		$(use_with png) \
		$(use_with pulseaudio) \
		$(use_with wavpack) \
		--with-distro="Gentoo"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS ChangeLog README AUTHORS
}
