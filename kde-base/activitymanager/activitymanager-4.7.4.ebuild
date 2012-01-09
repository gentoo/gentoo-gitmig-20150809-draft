# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/activitymanager/activitymanager-4.7.4.ebuild,v 1.2 2012/01/09 15:35:03 phajdan.jr Exp $

EAPI=4

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Activity manager"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug semantic-desktop"

DEPEND="$(add_kdebase_dep kdelibs 'semantic-desktop=')"
RDEPEND=${DEPEND}

KMEXTRACTONLY="
	nepomuk/
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		# $(cmake-utils_use_with zeitgeist QtZeitgeist)
		-DWITH_QtZeitgeist=NO
	)
	kde4-meta_src_configure
}
