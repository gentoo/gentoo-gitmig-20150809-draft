# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/csv/csv-0.5.0.ebuild,v 1.10 2004/06/25 01:27:58 agriffis Exp $

inherit distutils

DESCRIPTION="CSV Module for Python"
HOMEPAGE="http://www.object-craft.com.au/projects/csv/"
SRC_URI="http://www.object-craft.com.au/projects/csv/download/csv-0.5.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc ~sparc"
IUSE=""

DEPEND="virtual/python"

S="${WORKDIR}/${PN}"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
