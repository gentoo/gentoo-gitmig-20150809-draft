# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychart/pychart-1.39.ebuild,v 1.1 2006/02/08 09:33:49 lucass Exp $


inherit distutils

MY_P=${P/pychart/PyChart}
DESCRIPTION="Python library for creating charts"
HOMEPAGE="http://home.gna.org/pychart/"
SRC_URI="http://download.gna.org/pychart/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
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
