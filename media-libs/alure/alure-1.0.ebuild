# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alure/alure-1.0.ebuild,v 1.1 2009/12/13 15:23:46 ssuominen Exp $

EAPI=2
inherit cmake-utils

DESCRIPTION="The OpenAL Utility Toolkit"
HOMEPAGE="http://kcat.strangesoft.net/alure.html"
SRC_URI="http://kcat.strangesoft.net/alure-releases/${P}-src.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sndfile vorbis"

DEPEND=">=media-libs/openal-1
	sndfile? ( media-libs/libsndfile )
	vorbis? ( media-libs/libvorbis )"

PATCHES=( "${FILESDIR}/${P}-gcc44.patch"
	"${FILESDIR}/${P}-multilib.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DFLAC=OFF
		$(cmake-utils_use sndfile)
		$(cmake-utils_use vorbis)"

	cmake-utils_src_configure
}
