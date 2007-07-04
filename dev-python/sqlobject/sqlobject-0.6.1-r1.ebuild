# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlobject/sqlobject-0.6.1-r1.ebuild,v 1.6 2007/07/04 20:27:04 lucass Exp $

inherit distutils eutils

MY_P=${P/sqlobject/SQLObject}
DESCRIPTION="Object-relational mapper for Python"
HOMEPAGE="http://sqlobject.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="postgres mysql sqlite firebird doc"
RDEPEND=">=dev-lang/python-2.2
		postgres? ( <dev-python/psycopg-1.99 )
		mysql? ( >=dev-python/mysql-python-0.9.2-r1 )
		sqlite? ( <dev-python/pysqlite-2.0 )
		firebird? ( >=dev-python/kinterbasdb-3.0.2 )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#Add array type for Subway:
	epatch ${FILESDIR}/converters-${PV}-gentoo.diff
}

src_install() {
	distutils_src_install
	if use doc; then
		dodoc docs/*.txt
		dohtml docs/*.css docs/*.html
		docinto examples
		dodoc examples/*
	fi
}
