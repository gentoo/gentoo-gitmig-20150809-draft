# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-sql/cl-sql-2.10.14.ebuild,v 1.3 2004/07/14 16:15:34 agriffis Exp $

inherit common-lisp eutils

DESCRIPTION="A multi-platform SQL interface for Common Lisp"
HOMEPAGE="http://clsql.b9.com/
	http://packages.debian.org/unstable/devel/cl-sql.html
	http://www.cliki.net/CLSQL"
SRC_URI="http://files.b9.com/clsql/clsql-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="postgres mysql sqlite odbc"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-md5
	dev-lisp/cl-uffi
	postgres? ( dev-db/postgresql )
	mysql? ( dev-db/mysql )
	sqlite? ( dev-db/sqlite )
	odbc? ( dev-db/unixODBC )"

S=${WORKDIR}/clsql-${PV}

# CLPACKAGE='clsql-base clsql clsql-uffi'
# use postgresql && CLPACKAGE="${CLPACKAGE} clsql-postgresql clsql-postgresql-socket"
# use mysql &&	CLPACKAGE="${CLPACKAGE} clsql-mysql"
# use sqlite && CLPACKAGE="${CLPACKAGE} clsql-sqlite"

# Have to do this in a static manner, it seems???

CLPACKAGE='clsql-base clsql clsql-uffi clsql-postgresql clsql-postgresql-socket clsql-mysql clsql-sqlite clsql-odbc clsql-classic'

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-no-shared-object-asdf-gentoo.patch
}

src_compile() {
	make -C uffi
	use mysql && make -C db-mysql
	use postgres && make -C db-postgresql
}

src_install() {
	dodir $CLSYSTEMROOT
	dodir $CLSOURCEROOT
	# cl-sql-base
	insinto $CLSOURCEROOT/clsql-base/base; doins base/*.lisp
	insinto $CLSOURCEROOT/clsql-base; doins clsql-base.asd
	dosym $CLSOURCEROOT/clsql-base/clsql-base.asd $CLSYSTEMROOT/clsql-base.asd
	# cl-sql
	insinto $CLSOURCEROOT/clsql/sql; doins sql/*.lisp
	insinto $CLSOURCEROOT/clsql; doins clsql.asd
	dosym $CLSOURCEROOT/clsql/clsql.asd $CLSYSTEMROOT/clsql.asd
	# cl-sql-classic
	insinto $CLSOURCEROOT/clsql-classic/classic; doins classic/*.lisp
	insinto $CLSOURCEROOT/clsql-classic; doins clsql-classic.asd
	dosym $CLSOURCEROOT/clsql-classic/clsql-classic.asd $CLSYSTEMROOT/clsql-classic.asd
	# cl-sql-uffi
	exeinto /usr/lib/clsql
	doexe uffi/uffi.so
	insinto $CLSOURCEROOT/clsql-uffi/uffi; doins uffi/*.lisp uffi/uffi.c
	insinto $CLSOURCEROOT/clsql-uffi; doins clsql-uffi.asd
	dosym $CLSOURCEROOT/clsql-uffi/clsql-uffi.asd $CLSYSTEMROOT/clsql-uffi.asd

	if use postgres; then
		# cl-sql-postgresql-socket
		insinto $CLSOURCEROOT/clsql-postgresql-socket/db-postgresql-socket
		doins db-postgresql-socket/*.lisp
		insinto $CLSOURCEROOT/clsql-postgresql-socket
		doins clsql-postgresql-socket.asd
		dosym $CLSOURCEROOT/clsql-postgresql-socket/clsql-postgresql-socket.asd \
			$CLSYSTEMROOT/clsql-postgresql-socket.asd
		# cl-sql-postgresql (UFFI interface)
		insinto $CLSOURCEROOT/clsql-postgresql/db-postgresql
		doins db-postgresql/*.lisp
		insinto $CLSOURCEROOT/clsql-postgresql
		doins clsql-postgresql.asd
		dosym $CLSOURCEROOT/clsql-postgresql/clsql-postgresql.asd \
			$CLSYSTEMROOT/clsql-postgresql.asd
	fi

	if use mysql; then
		# cl-sql-mysql
		insinto $CLSOURCEROOT/clsql-mysql/db-mysql
		doins db-mysql/*.lisp db-mysql/mysql.c
		insinto $CLSOURCEROOT/clsql-mysql
		doins clsql-mysql.asd
		dosym $CLSOURCEROOT/clsql-mysql/clsql-mysql.asd $CLSYSTEMROOT/clsql-mysql.asd
		exeinto /usr/lib/clsql
		doexe db-mysql/mysql.so
	fi

	if use sqlite; then
		insinto $CLSOURCEROOT/clsql-sqlite/db-sqlite
		doins db-sqlite/*.lisp
		insinto $CLSOURCEROOT/clsql-sqlite
		doins clsql-sqlite.asd
		dosym $CLSOURCEROOT/clsql-sqlite/clsql-sqlite.asd $CLSYSTEMROOT/clsql-sqlite.asd
	fi

	if use odbc; then
		insinto $CLSOURCEROOT/clsql-odbc/db-odbc
		doins db-odbc/*.lisp
		insinto $CLSOURCEROOT/clsql-odbc
		doins clsql-odbc.asd
		dosym $CLSOURCEROOT/clsql-odbc/clsql-odbc.asd $CLSYSTEMROOT/clsql-odbc.asd
	fi

	dodoc CONTRIBUTORS COPYING* ChangeLog INSTALL NEWS README TODO
	tar xfz doc/html.tar.gz -C ${D}/usr/share/doc/${PF}/
#	do-debian-credits
}
