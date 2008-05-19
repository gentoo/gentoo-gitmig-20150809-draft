# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-sql/cl-sql-3.7.1.ebuild,v 1.3 2008/05/19 19:41:52 dev-zero Exp $

inherit common-lisp eutils multilib

DESCRIPTION="A multi-platform SQL interface for Common Lisp"
HOMEPAGE="http://clsql.b9.com/
	http://packages.debian.org/unstable/devel/cl-sql.html
	http://www.cliki.net/CLSQL"
SRC_URI="http://files.b9.com/clsql/clsql-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="postgres mysql sqlite sqlite3 odbc"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-md5
	>=dev-lisp/cl-uffi-1.5.7
	postgres? ( virtual/postgresql-base )
	mysql? ( virtual/mysql )
	sqlite? ( =dev-db/sqlite-2* )
	sqlite3? ( =dev-db/sqlite-3* )
	odbc? ( dev-db/unixODBC )"

S=${WORKDIR}/clsql-${PV}

CLPACKAGE='clsql clsql-uffi clsql-postgresql clsql-postgresql-socket clsql-mysql clsql-odbc clsql-sqlite clsql-sqlite3'

src_unpack() {
	unpack ${A}
	sed -i "s,/usr/lib,/usr/$(get_libdir),g" ${S}/clsql-{mysql,uffi}.asd
	sed -i 's,"usr" "lib","usr" "'$(get_libdir)'",g' ${S}/clsql-{mysql,uffi}.asd
}

src_compile() {
	make -C uffi || die
	if use mysql; then
		make -C db-mysql || die
	fi
}

src_install() {
	dodir $CLSYSTEMROOT
	dodir $CLSOURCEROOT

	insinto $CLSOURCEROOT/clsql/sql; doins sql/*.lisp
	insinto $CLSOURCEROOT/clsql; doins clsql.asd
	dosym $CLSOURCEROOT/clsql/clsql.asd $CLSYSTEMROOT/clsql.asd

	insinto $CLSOURCEROOT/clsql-uffi/uffi; doins uffi/*.lisp
	insinto $CLSOURCEROOT/clsql-uffi; doins clsql-uffi.asd
	dosym $CLSOURCEROOT/clsql-uffi/clsql-uffi.asd $CLSYSTEMROOT/clsql-uffi.asd
	exeinto /usr/$(get_libdir)/clsql/; doexe uffi/clsql_uffi.so

	if use postgres; then
		insinto $CLSOURCEROOT/clsql-postgresql/db-postgresql; doins db-postgresql/*.lisp
		insinto $CLSOURCEROOT/clsql-postgresql; doins clsql-postgresql.asd
		dosym $CLSOURCEROOT/clsql-postgresql/clsql-postgresql.asd $CLSYSTEMROOT/clsql-postgresql.asd
	fi

	insinto $CLSOURCEROOT/clsql-postgresql-socket/db-postgresql-socket
	doins db-postgresql-socket/*.lisp
	insinto $CLSOURCEROOT/clsql-postgresql-socket
	doins clsql-postgresql-socket.asd
	dosym $CLSOURCEROOT/clsql-postgresql-socket/clsql-postgresql-socket.asd \
		$CLSYSTEMROOT/clsql-postgresql-socket.asd

	if use mysql; then
		insinto $CLSOURCEROOT/clsql-mysql/db-mysql; doins db-mysql/*.lisp db-mysql/*.c
		insinto $CLSOURCEROOT/clsql-mysql; doins clsql-mysql.asd
		dosym $CLSOURCEROOT/clsql-mysql/clsql-mysql.asd $CLSYSTEMROOT/clsql-mysql.asd
		exeinto /usr/$(get_libdir)/clsql/; doexe db-mysql/clsql_mysql.so
	fi

	if use odbc; then
		insinto $CLSOURCEROOT/clsql-odbc/db-odbc; doins db-odbc/*.lisp
		insinto $CLSOURCEROOT/clsql-odbc; doins clsql-odbc.asd
		dosym $CLSOURCEROOT/clsql-odbc/clsql-odbc.asd $CLSYSTEMROOT/clsql-odbc.asd
	fi

	if use sqlite; then
		insinto $CLSOURCEROOT/clsql-sqlite/db-sqlite; doins db-sqlite/*.lisp
		insinto $CLSOURCEROOT/clsql-sqlite; doins clsql-sqlite.asd
		dosym $CLSOURCEROOT/clsql-sqlite/clsql-sqlite.asd $CLSYSTEMROOT/clsql-sqlite.asd
	fi

	if use sqlite3; then
		insinto $CLSOURCEROOT/clsql-sqlite3/db-sqlite3; doins db-sqlite3/*.lisp
		insinto $CLSOURCEROOT/clsql-sqlite3; doins clsql-sqlite3.asd
		dosym $CLSOURCEROOT/clsql-sqlite3/clsql-sqlite3.asd $CLSYSTEMROOT/clsql-sqlite3.asd
	fi

	dodoc BUGS CONTRIBUTORS COPYING* ChangeLog INSTALL LATEST-TEST-RESULTS NEWS README TODO
	dodoc doc/clsql.pdf
	tar xfz doc/html.tar.gz -C ${D}/usr/share/doc/${PF}/
	do-debian-credits
	insinto /usr/share/doc/${PF}/examples
	doins examples/*

	dodir /etc
	cat >${D}/etc/clsql-init.lisp <<EOF
(clsql:push-library-path #p"/usr/$(get_libdir)/")
(clsql:push-library-path #p"/usr/$(get_libdir)/clsql/")
EOF
}
