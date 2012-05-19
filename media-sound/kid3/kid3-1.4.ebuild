# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-1.4.ebuild,v 1.6 2012/05/19 09:07:30 ssuominen Exp $

EAPI=3
inherit kde4-base

DESCRIPTION="A simple tag editor for KDE"
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE="flac +handbook mp3 mp4 +taglib vorbis"

RDEPEND="
	flac? ( media-libs/flac[cxx]
		media-libs/libvorbis )
	mp3? ( media-libs/id3lib )
	mp4? ( media-libs/libmp4v2:0 )
	taglib? ( media-libs/taglib )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}"

src_configure() {
	# -DWITH_TUNEPIMP is using deprecated RDF WebService
	# -DWITH_KDE=OFF doesn't compile, last checked 1.4

	mycmakeargs+=(
		$(cmake-utils_use_with flac)
		$(cmake-utils_use_with mp3 ID3LIB)
		$(cmake-utils_use_with mp4 MP4V2)
		$(cmake-utils_use_with taglib)
		"-DWITH_TUNEPIMP=OFF"
		)

	if use flac; then
		mycmakeargs+=( "-DWITH_VORBIS=ON" )
	else
		mycmakeargs+=( $(cmake-utils_use_with vorbis) )
	fi

	kde4-base_src_configure
}
