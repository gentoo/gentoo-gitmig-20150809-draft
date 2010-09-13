# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclimate/pyclimate-1.2.2-r1.ebuild,v 1.3 2010/09/13 21:01:50 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils

MY_P="${P/pyclimate/PyClimate}"

DESCRIPTION="Climate Data Analysis Module for Python"
HOMEPAGE="http://www.pyclimate.org/"
SRC_URI="http://fisica.ehu.es/jsaenz/pyclimate_files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="examples"

DEPEND=""
RDEPEND="
	dev-python/numpy
	>=dev-python/scientificpython-2.8
	>=sci-libs/netcdf-3.0"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	dodoc doc/* doc/dcdflib_doc/dcdflib* || die

	if use examples; then
		insinto /usr/share/${PF}
		doins -r examples test || die
	fi
}
