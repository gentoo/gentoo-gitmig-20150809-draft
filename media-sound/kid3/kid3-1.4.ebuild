# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-1.4.ebuild,v 1.3 2010/06/28 08:55:14 hwoarang Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A simple tag editor for KDE"
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="flac +handbook mp3 mp4 +taglib vorbis"

DEPEND="flac? ( media-libs/flac[cxx] )
	mp3? ( media-libs/id3lib )
	mp4? ( media-libs/libmp4v2 )
	taglib? ( media-libs/taglib )
	vorbis? ( media-libs/libvorbis )"

src_configure() {
	# tunepimp uses the old RDF WebService and should not be used...
	# and -WITH_KDE=OFF doesn't compile (last checked, 1.3)
	mycmakeargs+=(
		$(cmake-utils_use_with flac)
		$(cmake-utils_use_with mp3 ID3LIB)
		$(cmake-utils_use_with mp4 MP4V2)
		$(cmake-utils_use_with taglib)
		"-DWITH_TUNEPIMP=OFF"
		$(cmake-utils_use_with vorbis)
		)

	kde4-base_src_configure
}
