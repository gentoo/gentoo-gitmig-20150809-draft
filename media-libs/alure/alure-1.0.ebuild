# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alure/alure-1.0.ebuild,v 1.3 2010/04/27 20:11:55 ssuominen Exp $

EAPI=2
inherit cmake-utils

DESCRIPTION="The OpenAL Utility Toolkit"
HOMEPAGE="http://kcat.strangesoft.net/alure.html"
SRC_URI="http://kcat.strangesoft.net/alure-releases/${P}-src.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="sndfile vorbis"

DEPEND="media-libs/openal
	sndfile? ( media-libs/libsndfile )
	vorbis? ( media-libs/libvorbis )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-multilib.patch

	sed -i \
		-e "/DESTINATION/s:doc/alure:doc/${PF}:" \
		CMakeLists.txt || die
}

src_configure() {
	mycmakeargs=(
		"-DFLAC=OFF"
		$(cmake-utils_use sndfile)
		$(cmake-utils_use vorbis)
		)

	cmake-utils_src_configure
}
