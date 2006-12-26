# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlobject/sqlobject-0.7.2.ebuild,v 1.1 2006/12/26 23:58:11 dev-zero Exp $

inherit distutils

MY_PN=${PN/sqlobject/SQLObject}
DESCRIPTION="Object-relational mapper for Python"
HOMEPAGE="http://sqlobject.org/"
SRC_URI="http://cheeseshop.python.org/packages/source/S/${MY_PN}/${MY_PN}-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="postgres mysql sqlite firebird doc"
RDEPEND=">=dev-lang/python-2.2
		postgres? ( <dev-python/psycopg-1.99 )
		mysql? ( >=dev-python/mysql-python-0.9.2-r1 )
		sqlite? ( <dev-python/pysqlite-2.0 )
		firebird? ( >=dev-python/kinterbasdb-3.0.2 )
		>=dev-python/formencode-0.2.2"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	#We don't want to use setuptools until egg.seclass is solid
	rm -rf ez_setup
}

src_install() {
	distutils_src_install
	use doc && dodoc docs/*
}
