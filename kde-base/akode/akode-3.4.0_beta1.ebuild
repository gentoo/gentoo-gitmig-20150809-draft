# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akode/akode-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:25 danarmak Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="aRts plugins for various formats"
KEYWORDS="~x86"
IUSE="flac oggvorbis speex"
DEPEND="flac? ( media-libs/flac )
	oggvorbis? ( media-sound/vorbis-tools )
	speex? ( media-libs/speex )
	!=media-libs/speex-1.1.4
	media-libs/libsamplerate"

src_compile() {
	use oggvorbis && myconf="$myconf --with-vorbis=/usr" || myconf="$myconf --without-vorbis"

	use speex && myconf="$myconf --with-extra-includes=/usr/include/speex"

	kde-meta_src_compile
}
