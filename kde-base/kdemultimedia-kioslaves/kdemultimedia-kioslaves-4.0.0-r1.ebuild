# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kioslaves/kdemultimedia-kioslaves-4.0.0-r1.ebuild,v 1.2 2008/01/29 19:46:57 zlin Exp $

EAPI="1"

KMMODULE=kioslave
KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS="~amd64 ~x86"
IUSE="debug encode flac vorbis"
RESTRICT="test"

DEPEND="${DEPEND}
	>=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
	media-sound/cdparanoia
	encode? ( flac? ( >=media-libs/flac-1.1.2
		>=kde-base/kdelibs-4.0.0-r1:kde-4 )
		vorbis? ( media-libs/libvorbis ) )"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkcompactdisc/"
KMCOMPILEONLY="libkcddb/"

PATCHES="${FILESDIR}/${P}-flac-1.1.3.patch"

src_compile() {
	if use encode; then
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_with flac Flac)
			$(cmake-utils_use_with vorbis OggVorbis)"
	else
		mycmakeargs="${mycmakeargs}
			-DWITH_OggVorbis=OFF -DWITH_Flac=OFF"
	fi

	kde4-meta_src_compile
}

pkg_postinst() {
	if use encode; then
		echo
		elog "In order to use the lame plugin to encode mp3 files you will need to"
		elog "install media-sound/lame"
		echo
	fi
}
