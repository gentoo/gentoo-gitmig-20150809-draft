# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adodb-py/adodb-py-2.00.ebuild,v 1.8 2010/02/07 20:50:53 pva Exp $

EAPI="2"
inherit eutils distutils

MY_P=${PN}${PV//./}

DESCRIPTION="Active Data Objects Data Base library for Python"
HOMEPAGE="http://adodb.sourceforge.net/"
SRC_URI="mirror://sourceforge/adodb/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ia64 ppc x86"
IUSE="mysql postgres sqlite"

RDEPEND=">=dev-lang/python-2.3
	postgres? ( <dev-python/psycopg-1.99 )
	mysql? ( >=dev-python/mysql-python-0.9.2 )
	sqlite? ( >=dev-python/pysqlite-2.0 ) "
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${MY_P/py/}"

DOCS="LICENSE.txt README.txt"

src_prepare(){
	epatch "${FILESDIR}/${PN}_sandbox_violation.patch"
}
src_install() {
	distutils_src_install
	dohtml adodb-py-docs.htm icons/*.gif
}
