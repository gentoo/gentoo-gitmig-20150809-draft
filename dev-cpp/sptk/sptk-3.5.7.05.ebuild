# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-3.5.7.05.ebuild,v 1.3 2008/05/19 18:08:30 dev-zero Exp $

inherit eutils flag-o-matic autotools

IUSE="fltk odbc doc sqlite3 excel postgres aspell"

DESCRIPTION="C++ user interface toolkit for X with database and Excel support"
SRC_URI="http://www.sptk.net/sptk-${PV}.tbz2"
HOMEPAGE="http://www.sptk.net"

SLOT="3"
LICENSE="|| ( BSD )"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

DEPEND="dev-util/cmake
	fltk?     ( >=x11-libs/fltk-1.1.6 )
	odbc?     ( >=dev-db/unixODBC-2.2.6 )
	sqlite3?  ( >=dev-db/sqlite-3 )
	postgres? ( >=virtual/postgresql-base-8.0 )
	aspell?   ( >=app-text/aspell-0.50 )
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
	check_use sqlite3  SQLITE3
	check_use odbc     ODBC
	check_use aspell   ASPELL
	check_use fltk     FLTK
	check_use excel    EXCEL

	sed -r -i -e 's|SET \(LIBRARY_TYPE STATIC\)|SET \(LIBRARY_TYPE SHARED\)|' src/CMakeLists.txt

	cmake -D CMAKE_INSTALL_PREFIX:PATH=/usr ${SPTK_OPTIONS} .  || die "Configuration Failed"
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
