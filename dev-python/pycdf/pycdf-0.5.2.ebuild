# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycdf/pycdf-0.5.2.ebuild,v 1.3 2004/12/05 12:24:17 kloeri Exp $

inherit distutils

MY_P=${PN}-${PV:0:3}-${PV:4:1}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The pycdf package wraps the complete functionality of the Unidata netcdf library..."
HOMEPAGE="ftp://nordet.qc.dfo-mpo.gc.ca/pub/soft/pycdf"
SRC_URI="ftp://nordet.qc.dfo-mpo.gc.ca/pub/soft/pycdf/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="virtual/python
		>=app-sci/netcdf-3.5.0-r3
		dev-python/numeric"

DOCS="CHANGES doc/pycdf.txt"

src_install() {
	distutils_src_install
	use doc && ( cp -R examples ${D}/usr/share/doc/${PF}
			dohtml doc/pycdf.html )
}
