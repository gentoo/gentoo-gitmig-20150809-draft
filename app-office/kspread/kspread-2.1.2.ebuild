# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kspread/kspread-2.1.2.ebuild,v 1.4 2011/01/28 09:47:09 tampakrap Exp $

EAPI="3"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice spreadsheet application."

KEYWORDS="~ppc ~ppc64"
IUSE="solver"

DEPEND="
	dev-cpp/eigen:2
	solver? ( sci-libs/gsl )
	!>=x11-libs/qt-core-4.7.0
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kchart/
	interfaces/
	libs/
	filters/
	plugins/
"
KMEXTRA="filters/${KMMODULE}/"

KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Eigen2=ON
		$(cmake-utils_use_with solver GSL)"

	kde4-meta_src_configure
}
