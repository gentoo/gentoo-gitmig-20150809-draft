# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-uncommonsql/cl-uncommonsql-1.2.1.ebuild,v 1.1 2003/10/17 17:17:02 mkennedy Exp $

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

}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
