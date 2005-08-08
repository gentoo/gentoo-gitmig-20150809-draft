# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akode/akode-3.4.2.ebuild,v 1.2 2005/08/08 20:33:40 kloeri Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="aRts plugins for various formats"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa arts flac jack mp3 speex vorbis"
DEPEND="arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	flac? ( media-libs/flac )
	vorbis? ( media-sound/vorbis-tools )
	speex? ( media-libs/speex )
	!=media-libs/speex-1.1.4
	media-libs/libsamplerate
	mp3? ( media-libs/libmad )
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"

# MISSING: polypaudio - no gentoo ebuild as yet
# TODO: configure needs a pkg-config file for media-sound/jack to detect it

src_compile() {
	use speex && myconf="$myconf --with-extra-includes=/usr/include/speex"
	myconf="$myconf $(use_with mp3 libmad) $(use_with flac) $(use_with speex)
			$(use_with alsa) $(use_with jack) $(use_with vorbis)"

	kde-meta_src_compile
}
