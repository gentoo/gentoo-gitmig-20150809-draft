# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kioslaves/kdemultimedia-kioslaves-4.0.0-r1.ebuild,v 1.1 2008/01/29 05:42:23 ingmar Exp $

EAPI="1"

KMMODULE=kioslave
KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS="~amd64 ~x86"
IUSE="debug flac vorbis"
RESTRICT="test"

DEPEND="${DEPEND}
	>=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
	media-sound/cdparanoia
	flac? ( media-libs/flac )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkcompactdisc/"
KMCOMPILEONLY="libkcddb/"

PATCHES="${FILESDIR}/${P}-flac-1.1.3.patch"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with flac Flac)
		$(cmake-utils_use_with vorbis OggVorbis)"

	kde4-meta_src_compile
}

pkg_postinst() {
	echo
	elog "In order to use the lame plugin to encode mp3 files you will need to"
	elog "install media-sound/lame"
	echo
}
