# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-4.0.0-r1.ebuild,v 1.1 2008/01/28 01:53:36 zlin Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE multimedia module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="alsa debug encode htmlhandbook flac musicbrainz tunepimp vorbis"
LICENSE="GPL-2 LGPL-2"

RESTRICT="test"

DEPEND=">=kde-base/kdebase-${PV}:${SLOT}
	media-libs/taglib
	media-sound/cdparanoia
	alsa? ( media-libs/alsa-lib )
	encode? ( flac? ( >=media-libs/flac-1.1.2
		>=kde-base/kdelibs-4.0.0-r1:kde-4 )
		vorbis? ( media-libs/libvorbis ) )
	musicbrainz? ( media-libs/musicbrainz )
	tunepimp? ( media-libs/tunepimp )"

PATCHES="${FILESDIR}/${P}-flac-1.1.3.patch"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)
		$(cmake-utils_use_enable musicbrainz MusicBrainz)
		$(cmake-utils_use_with tunepimp TunePimp)"

	if use encode; then
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_with flac Flac)"
			$(cmake-utils_use_with vorbis OggVorbis)
	else
		mycmakeargs="${mycmakeargs}
			-DWITH_OggVorbis=OFF -DWITH_Flac=OFF"
	fi

	kde4-base_src_compile
}

pkg_postinst() {
	if use encode; then
		echo
		elog "In order to use the lame plugin to encode mp3 files you will need to"
		elog "install media-sound/lame"
		echo
	fi
}
