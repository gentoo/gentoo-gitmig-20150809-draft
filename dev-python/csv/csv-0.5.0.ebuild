# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/csv/csv-0.5.0.ebuild,v 1.1 2002/12/13 00:15:47 blauwers Exp $

S="${WORKDIR}/${PN}"

DESCRIPTION="CSV Module for Python"
SRC_URI="http://www.object-craft.com.au/projects/csv/download/csv-0.5.tar.gz"
HOMEPAGE="http://www.object-craft.com.au/projects/csv/"

KEYWORDS="~x86 ~alpha ~ppc ~sparc"
DEPEND="virtual/python"
LICENSE="python"
SLOT="0"

inherit distutils

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
