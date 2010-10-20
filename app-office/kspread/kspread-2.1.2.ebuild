# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kspread/kspread-2.1.2.ebuild,v 1.3 2010/10/20 20:42:44 dilfridge Exp $

EAPI="2"

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
