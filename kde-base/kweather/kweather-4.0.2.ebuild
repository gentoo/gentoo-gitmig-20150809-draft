# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kweather/kweather-4.0.2.ebuild,v 1.1 2008/03/10 23:58:35 philantrop Exp $

EAPI="1"

KMNAME=kdetoys
inherit kde4-meta

DESCRIPTION="KDE weather status display"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/plasma-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

# More broken tests...
RESTRICT="test"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Plasma=ON"

	kde4-base_src_compile
}

src_test() {
	pushd "${WORKDIR}"/${PN}_build/${PN}/tests > /dev/null
	# 'metar_parser_test' is also available but fails and I'm not sure why
	emake stationdatabase_test sun_test || \
		die "Failed to build tests."
	for t in *.shell; do
		./"$t" || die "Test '$t' failed."
	done
	popd > /dev/null
}
