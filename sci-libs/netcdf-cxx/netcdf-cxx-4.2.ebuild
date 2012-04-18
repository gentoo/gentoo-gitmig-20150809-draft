# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/netcdf-cxx/netcdf-cxx-4.2.ebuild,v 1.1 2012/04/18 19:11:48 bicatali Exp $

EAPI=4

inherit autotools-utils versionator

MYP=${PN}4-${PV}

DESCRIPTION="C++ library for netCDF"
HOMEPAGE="http://www.unidata.ucar.edu/software/netcdf/"
SRC_URI="https://www.unidata.ucar.edu/downloads/netcdf/ftp/${MYP}.tar.gz"

LICENSE="UCAR-Unidata"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples static-libs"

RDEPEND=">=sci-libs/netcdf-4.2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}"

src_install() {
	autotools-utils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
