# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/juk/juk-4.5.4.ebuild,v 1.1 2010/12/02 21:15:53 alexxy Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Jukebox and music manager for KDE."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug musicbrainz"

DEPEND="
	>=media-libs/taglib-1.6
	musicbrainz? ( media-libs/tunepimp )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with musicbrainz TunePimp)
	)

	kde4-meta_src_configure
}
