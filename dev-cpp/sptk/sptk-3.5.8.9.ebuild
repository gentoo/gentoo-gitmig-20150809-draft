# Copyright 2006-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-3.5.8.9.ebuild,v 1.1 2009/01/19 11:11:40 iluxa Exp $

EAPI=1

inherit eutils flag-o-matic multilib

IUSE="fltk odbc doc sqlite examples excel postgres aspell mysql"

DESCRIPTION="C++ user interface toolkit for X with database and Excel support"
SRC_URI="http://www.sptk.net/sptk-${PV}.tbz2"
HOMEPAGE="http://www.sptk.net"

SLOT="3"
LICENSE="|| ( BSD )"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

RDEPEND="fltk?    ( >=x11-libs/fltk-1.1.6:1.1 )
	odbc?     ( >=dev-db/unixODBC-2.2.6 )
	sqlite?   ( >=dev-db/sqlite-3 )
	postgres? ( >=virtual/postgresql-base-8.0 )
	mysql?    ( dev-db/mysql )
	aspell?   ( >=app-text/aspell-0.50 )"

DEPEND="${RDEPEND}
	dev-util/cmake
	doc?      ( app-doc/doxygen )"

check_use() {
	if use ${1}; then
		SPTK_OPTIONS="${SPTK_OPTIONS} -DNO_${2}:BOOLEAN=FALSE"
	else
		SPTK_OPTIONS="${SPTK_OPTIONS} -DNO_${2}:BOOLEAN=TRUE"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	check_use examples EXAMPLES
	check_use postgres POSTGRESQL
	check_use mysql    MYSQL
	check_use sqlite3  SQLITE3
	check_use odbc     ODBC
	check_use aspell   ASPELL
	check_use fltk     FLTK
	check_use excel    EXCEL

	cmake -D CMAKE_INSTALL_PREFIX:PATH=/usr -D LIBDIR=$(get_libdir) ${SPTK_OPTIONS} .  || die "Configuration Failed"
}

src_compile() {

	emake || die "Parallel Make Failed"

	if use doc; then
		cd "${S}"
		einfo "Fixing sptk3.doxygen"
		sed -i -e 's,/cvs/sptk3/,,g' sptk3.doxygen
		einfo "Building docs"
		doxygen sptk3.doxygen
	fi

}

src_install () {

	make DESTDIR="${D}" install || die "Installation failed"

	dodoc README AUTHORS

	dodir /usr/share/doc/${PF}
	cp -r "${S}"/docs/* "${D}"/usr/share/doc/${PF}
	if use doc; then
		rm -fr "${D}/usr/share/doc/${PF}/latex"
		cp -rf "${S}/pictures" "${D}/usr/share/doc/${PF}"
	fi
}
