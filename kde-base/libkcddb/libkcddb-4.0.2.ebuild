# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcddb/libkcddb-4.0.2.ebuild,v 1.1 2008/03/10 23:59:42 philantrop Exp $

EAPI="1"

KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="KDE library for CDDB"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook musicbrainz"
RESTRICT="test" # last checked on 4.0.2.

DEPEND="${DEPEND}
	musicbrainz? ( media-libs/musicbrainz )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable musicbrainz MusicBrainz)"
	kde4-meta_src_compile
}
