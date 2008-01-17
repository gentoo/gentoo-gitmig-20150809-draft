# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-4.0.0.ebuild,v 1.1 2008/01/17 23:50:57 philantrop Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE multimedia module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook alsa flac musicbrainz tunepimp vorbis"  
LICENSE="GPL-2 LGPL-2"

RESTRICT="test"

DEPEND="media-libs/taglib
	media-sound/cdparanoia
	vorbis? ( media-libs/libvorbis )
	tunepimp? ( media-libs/tunepimp )
	musicbrainz? ( media-libs/musicbrainz )
	alsa? ( media-libs/alsa-lib )
	>=kde-base/kdebase-${PV}:${SLOT}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with tunepimp TunePimp)
		$(cmake-utils_use_with vorbis OggVorbis)
		$(cmake-utils_use_with alsa Alsa)
		$(cmake-utils_use_enable musicbrainz MusicBrainz)"

	kde4-base_src_compile
}

pkg_postinst() {
	echo
	elog "In order to use the lame plugin to encode mp3 files you will need to"
	elog "install media-sound/lame"
	echo
}
