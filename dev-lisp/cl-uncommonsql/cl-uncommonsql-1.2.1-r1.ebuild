# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-uncommonsql/cl-uncommonsql-1.2.1-r1.ebuild,v 1.1 2004/02/12 09:13:21 mkennedy Exp $

inherit common-lisp

DESCRIPTION="UncommonSQL is a database integration kit for Common Lisp. It provides a CommonSQL-compatible interface with a functional SQL syntax and a CLOS integrated Object-to-Relational mapping. You can serialize complete CLOS objects into an RDBMS."
HOMEPAGE="http://alpha.onshored.com/lisp-software/#uncommonsql"
SRC_URI="http://alpha.onshored.com/debian/local/${PN}_${PV}.orig.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="postgres mysql"
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-odcl
	virtual/commonlisp
	postgres? ( dev-db/postgresql )
	mysql? ( dev-db/mysql )"

CLPACKAGE=uncommonsql

use postgres && CLPACKAGE="${CLPACKAGE} uncommonsql-postgresql"
use mysql && CLPACKAGE="${CLPACKAGE} uncommonsql-mysql"

S=${WORKDIR}/${P}

src_install() {
	insinto /usr/share/common-lisp/source/uncommonsql
	doins *.lisp uncommonsql.system
	insinto /usr/share/common-lisp/source/uncommonsql/sql
	doins sql/*.lisp
	insinto /usr/share/common-lisp/source/uncommonsql/sql/tests
	doins sql/tests/*.lisp
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/uncommonsql/uncommonsql.system \
		/usr/share/common-lisp/systems/uncommonsql.system
	dodoc CONTRIB* COPYING ChangeLog INSTALL README VERSION TODO

	if use postgres; then
		insinto /usr/share/common-lisp/source/uncommonsql/dbms/postgresql
		doins dbms/postgresql/*.lisp
		dosym /usr/share/common-lisp/source/uncommonsql \
			/usr/share/common-lisp/source/uncommonsql-postgresql
		dodir /usr/share/common-lisp/systems
		grep -v mk:oos dbms/postgresql/system.lisp \
			>${D}/usr/share/common-lisp/systems/uncommonsql-postgresql.system
	fi

	if use mysql; then
		insinto /usr/share/common-lisp/source/uncommonsql/dbms/mysql
		doins dbms/mysql/*.lisp
		dosym /usr/share/common-lisp/source/uncommonsql \
			/usr/share/common-lisp/source/uncommonsql-mysql
		dodir /usr/share/common-lisp/systems
		grep -v mk:oos dbms/mysql/system.lisp \
			>${D}/usr/share/common-lisp/systems/uncommonsql-mysql.system
	fi
}
