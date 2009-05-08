# Copyright 2006-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-3.5.8.10.ebuild,v 1.6 2009/05/08 09:09:04 iluxa Exp $

EAPI=1

inherit multilib cmake-utils

IUSE="fltk odbc doc sqlite excel postgres aspell mysql"

DESCRIPTION="C++ user interface toolkit for X with database and Excel support"
SRC_URI="http://www.sptk.net/sptk-${PV}.tbz2"
HOMEPAGE="http://www.sptk.net"

SLOT="3"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

RDEPEND="fltk?    ( >=x11-libs/fltk-1.1.6:1.1 )
	odbc?     ( >=dev-db/unixODBC-2.2.6 )
	sqlite?   ( >=dev-db/sqlite-3 )
	postgres? ( >=virtual/postgresql-base-8.0 )
	mysql?    ( virtual/mysql )
	aspell?   ( >=app-text/aspell-0.50 )"

DEPEND="${RDEPEND}
	doc?      ( app-doc/doxygen )"

CMAKE_IN_SOURCE_BUILD=1

src_compile() {
	local mycmakeargs="$(cmake-utils_use_no postgres POSTGRESQL)
	$(cmake-utils_use_no mysql MYSQL)
	$(cmake-utils_use_no sqlite SQLITE3)
	$(cmake-utils_use_no odbc ODBC)
	$(cmake-utils_use_no aspell ASPELL)
	$(cmake-utils_use_no fltk FLTK)
	$(cmake-utils_use_no excel EXCEL)"

	mycmakeargs="${mycmakeargs} -D CMAKE_INSTALL_PREFIX:PATH=/usr -D LIBDIR=$(get_libdir) ${SPTK_OPTIONS} -DNO_EXAMPLES:BOOLEAN=TRUE"
	einfo "mycmakeargs=${mycmakeargs}"

	cmake-utils_src_configure

	cmake-utils_src_compile
	if use doc; then
		cd "${S}"
		einfo "Fixing sptk3.doxygen"
		sed -i -e 's,/cvs/sptk3/,,g' sptk3.doxygen
		einfo "Building docs"
		doxygen sptk3.doxygen
	fi

}

src_install () {

	DOCS="README AUTHORS"
	cmake-utils_src_install

	dodir /usr/share/doc/${PF}
	cp -r "${S}"/docs/* "${D}"/usr/share/doc/${PF}
	if use doc; then
		rm -fr "${D}/usr/share/doc/${PF}/latex"
		cp -rf "${S}/pictures" "${D}/usr/share/doc/${PF}"
	fi
}
