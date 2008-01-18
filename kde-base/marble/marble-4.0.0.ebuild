# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/marble/marble-4.0.0.ebuild,v 1.1 2008/01/18 01:43:37 ingmar Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE: generic geographical map widget"
KEYWORDS="~amd64 ~x86"
IUSE="debug designer-plugin htmlhandbook gps test"

# FIXME: undefined reference when building tests. RESTRICTed for now.
RESTRICT="test"
# FIXME: marble can install without kdelibs. there should be USE=kde for this..

COMMONDEPEND="gps? ( sci-geosciences/gpsd )"
DEPEND="${DEPEND} ${COMMONDEPEND}"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

src_compile() {
	epatch "${FILESDIR}/${P}-fix-tests.patch"

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)"

	if use gps; then
		mycmakeargs="${mycmakeargs} -DHAVE_LIBGPS=1"
	else
		sed -i -e 's:FIND_LIBRARY(libgps_LIBRARIES gps):# LIBGPS DISABLED &:' \
			marble/Findlibgps.cmake || die "sed failed."
	fi

	kde4-meta_src_compile
}

src_test() {
	mycmakeargs="${mycmakeargs} -DENABLE_TESTS=TRUE"

	kde4-meta_src_test
}
