# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/csv/csv-1.0.ebuild,v 1.1 2003/03/21 18:29:11 lordvan Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="CSV Module for Python"
SRC_URI="http://www.object-craft.com.au/projects/csv/download/${P}.tar.gz"
HOMEPAGE="http://www.object-craft.com.au/projects/csv/"

IUSE=""
KEYWORDS="~x86 ~alpha ~ppc ~sparc"
DEPEND="virtual/python"
LICENSE="PYTHON"
SLOT="0"

inherit distutils

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
