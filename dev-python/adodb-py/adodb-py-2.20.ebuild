# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adodb-py/adodb-py-2.20.ebuild,v 1.2 2009/09/19 05:38:48 neurogeek Exp $

EAPI="2"
NEED_PYTHON=2.3

inherit distutils

MY_PV=${PV//./}
MY_P=${PN/-py/}-${MY_PV}

DESCRIPTION="Active Data Objects Data Base library for Python"
HOMEPAGE="http://adodb.sourceforge.net/"
SRC_URI="mirror://sourceforge/adodb/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="mysql postgres sqlite"

RDEPEND="postgres? ( <dev-python/psycopg-1.99 )
	mysql? ( >=dev-python/mysql-python-0.9.2 )
	sqlite? ( >=dev-python/pysqlite-2.0 ) "
DEPEND="${RDEPEND}
	app-arch/unzip"

PYTHON_MODNAME="adodb"

S=${WORKDIR}/${MY_P}

src_prepare(){
	epatch "${FILESDIR}/${PN}_sandbox_violation.patch"
}

src_install() {
	distutils_src_install
	dohtml adodb-py-docs.htm icons/*.gif
}
