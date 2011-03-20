# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-3.5.8.14-r1.ebuild,v 1.5 2011/03/20 20:19:29 jlec Exp $

EAPI=1

inherit cmake-utils

DESCRIPTION="C++ user interface toolkit for X with database and Excel support"
SRC_URI="http://www.sptk.net/sptk-${PV}.tbz2"
HOMEPAGE="http://www.sptk.net"

SLOT="3"
LICENSE="BSD"
KEYWORDS="~alpha amd64 ~mips ~ppc ~sparc x86"
IUSE="fltk odbc doc sqlite excel postgres aspell mysql gnutls"

RDEPEND="
	aspell? ( >=app-text/aspell-0.50 )
	fltk? ( x11-libs/fltk:1 )
	gnutls? ( net-libs/gnutls )
	mysql? ( virtual/mysql )
	odbc? ( >=dev-db/unixODBC-2.2.6 )
	postgres? ( >=dev-db/postgresql-base-8.0 )
	sqlite? ( >=dev-db/sqlite-3 )"

DEPEND="${RDEPEND}
	doc?      ( app-doc/doxygen )"

CMAKE_IN_SOURCE_BUILD=1

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/sptk-gcc-4.4.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
}

src_compile() {
	local mycmakeargs="$(cmake-utils_use_no postgres POSTGRESQL)
	$(cmake-utils_use_no mysql MYSQL)
	$(cmake-utils_use_no sqlite SQLITE3)
	$(cmake-utils_use_no odbc ODBC)
	$(cmake-utils_use_no aspell ASPELL)
	$(cmake-utils_use_no fltk FLTK)
	$(cmake-utils_use_no excel EXCEL)
	$(cmake-utils_use_no gnutls TLS)"

	mycmakeargs="${mycmakeargs} -D CMAKE_INSTALL_PREFIX:PATH=/usr -D LIBDIR=$(get_libdir) ${SPTK_OPTIONS} -DNO_EXAMPLES:BOOLEAN=TRUE"

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
