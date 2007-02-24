# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycdf/pycdf-0.6.2_rc1.ebuild,v 1.2 2007/02/24 16:04:43 beandog Exp $

inherit distutils

MY_P=${PN}-${PV:0:3}-${PV:4:1}-${PV:6:3}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Python interface to scientific netCDF library."
HOMEPAGE="http://pysclint.sourceforge.net/pycdf/"
SRC_URI="mirror://sourceforge/pysclint/${MY_P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="doc"

DEPEND="virtual/python
		>=sci-libs/netcdf-3.6.1
		dev-python/numeric"

DOCS="CHANGES doc/pycdf.txt"

src_install() {
	distutils_src_install
	use doc && ( cp -R examples ${D}/usr/share/doc/${PF}
			dohtml doc/pycdf.html )
}
