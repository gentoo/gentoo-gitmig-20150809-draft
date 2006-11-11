# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychart/pychart-1.39.ebuild,v 1.3 2006/11/11 17:35:25 peper Exp $


inherit distutils

MY_P=${P/pychart/PyChart}
DESCRIPTION="Python library for creating charts"
HOMEPAGE="http://home.gna.org/pychart/"
SRC_URI="http://download.gna.org/pychart/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2
	>=sys-apps/sed-4
	virtual/ghostscript"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/demos
	doins demos/*
}
