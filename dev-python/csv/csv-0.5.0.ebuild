# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/csv/csv-0.5.0.ebuild,v 1.5 2003/06/22 12:15:59 liquidx Exp $

S="${WORKDIR}/${PN}"

DESCRIPTION="CSV Module for Python"
SRC_URI="http://www.object-craft.com.au/projects/csv/download/csv-0.5.tar.gz"
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
