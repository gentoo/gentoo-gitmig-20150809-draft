# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kioslaves/kdemultimedia-kioslaves-4.0.0.ebuild,v 1.1 2008/01/17 23:51:16 philantrop Exp $

EAPI="1"

KMMODULE=kioslave
KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS="~amd64 ~x86"
IUSE="debug flac vorbis"
RESTRICT="test"

# FIXME: find libOggFLAC.so
#	flac? ( media-libs/flac )
DEPEND="${DEPEND}
	>=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
	media-sound/cdparanoia
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkcompactdisc/"
KMCOMPILEONLY="libkcddb/"

src_compile() {
	# FIXME: there should be a flac flag, but it doesn't work since I can't
	# figure out how to get libOggFLAC.so
	#	$(cmake-utils_use_with flac Flac)
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with vorbis OggVorbis)"

	kde4-meta_src_compile
}

pkg_postinst() {
	echo
	elog "In order to use the lame plugin to encode mp3 files you will need to"
	elog "install media-sound/lame"
	echo
}
