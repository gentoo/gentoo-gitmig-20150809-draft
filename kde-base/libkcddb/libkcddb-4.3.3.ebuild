# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcddb/libkcddb-4.3.3.ebuild,v 1.7 2010/01/19 02:21:42 jer Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE library for CDDB"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE="debug musicbrainz"

# tests fail / timeout, last checked for 4.3.3
RESTRICT=test

DEPEND="
	musicbrainz? ( media-libs/musicbrainz:1 )
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with musicbrainz MusicBrainz)"

	kde4-meta_src_configure
}
