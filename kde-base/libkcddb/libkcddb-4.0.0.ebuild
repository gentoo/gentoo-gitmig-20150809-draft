# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcddb/libkcddb-4.0.0.ebuild,v 1.1 2008/01/18 01:25:31 ingmar Exp $

EAPI="1"

KMNAME=kdemultimedia

inherit kde4-meta

DESCRIPTION="KDE library for CDDB"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook musicbrainz"
RESTRICT="test"

DEPEND="${DEPEND}
	musicbrainz? ( media-libs/musicbrainz )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable musicbrainz MusicBrainz)"
	kde4-meta_src_compile
}
