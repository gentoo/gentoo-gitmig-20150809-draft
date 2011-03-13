# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kspread/kspread-2.2.2.ebuild,v 1.6 2011/03/13 08:29:23 dilfridge Exp $

EAPI="3"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice spreadsheet application."

KEYWORDS="amd64 x86"
IUSE="+solver"

DEPEND="<kde-base/kdelibs-4.6
	dev-cpp/eigen:2
	solver? ( sci-libs/gsl )
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
	mycmakeargs=(
		-DWITH_Eigen2=ON
		$(cmake-utils_use_with solver GSL)
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${ED}/usr/include/config-opengl.h"
}
