# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adodb-py/adodb-py-1.0.1.ebuild,v 1.1 2004/08/10 03:58:00 pythonhead Exp $

inherit distutils

MY_P=${PN}${PV//./}
DESCRIPTION="Active Data Objects Data Base library for Python"
HOMEPAGE="http://php.weblogs.com/adodb_python"
SRC_URI="mirror://sourceforge/adodb/${MY_P}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="virtual/python"
S="${WORKDIR}/${PN/-py/}"
DOCS="LICENSE.txt README.txt"

src_install() {
	distutils_src_install
	dohtml adodb-py-docs.htm icons/*.gif
}
