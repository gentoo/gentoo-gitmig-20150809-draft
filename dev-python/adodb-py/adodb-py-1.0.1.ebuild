# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adodb-py/adodb-py-1.0.1.ebuild,v 1.4 2004/11/04 16:12:29 pythonhead Exp $

inherit distutils

MY_P=${PN}${PV//./}
DESCRIPTION="Active Data Objects Data Base library for Python"
HOMEPAGE="http://adodb.sourceforge.net/"
SRC_URI="mirror://sourceforge/adodb/${MY_P}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="mysql postgresql"
RDEPEND=">=dev-lang/python-2.3
	postgresql? ( >=dev-python/psycopg-1.1.5.1 )
	mysql? ( >=dev-python/mysql-python-0.9.2 )
	app-arch/unzip"
S="${WORKDIR}/${PN/-py/}"
DOCS="LICENSE.txt README.txt"

src_install() {
	distutils_src_install
	dohtml adodb-py-docs.htm icons/*.gif
}
