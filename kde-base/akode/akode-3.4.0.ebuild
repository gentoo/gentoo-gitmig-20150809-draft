# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akode/akode-3.4.0.ebuild,v 1.3 2005/03/18 16:41:12 morfic Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="aRts plugins for various formats"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="flac oggvorbis speex mad arts alsa jack"
DEPEND="arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	flac? ( media-libs/flac )
	oggvorbis? ( media-sound/vorbis-tools )
	speex? ( media-libs/speex )
	!=media-libs/speex-1.1.4
	media-libs/libsamplerate
	mad? ( media-libs/libmad )
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"

# MISSING: polypaudio - no gentoo ebuild as yet
# TODO: configure needs a pkg-config file for media-sound/jack to detect it

src_compile() {
	use speex && myconf="$myconf --with-extra-includes=/usr/include/speex"
	myconf="$myconf $(use_with mad libmad) $(use_with flac) $(use_with speex)
			$(use_with alsa) $(use_with jack) $(use_with oggvorbis vorbis)"

	kde-meta_src_compile
}
