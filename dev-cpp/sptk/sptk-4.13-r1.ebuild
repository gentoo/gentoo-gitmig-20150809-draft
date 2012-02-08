# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-4.13-r1.ebuild,v 1.2 2012/02/08 19:29:53 ago Exp $

EAPI=4
CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils multilib

DESCRIPTION="C++ user interface toolkit for X with database and Excel support"
HOMEPAGE="http://www.sptk.net/"
SRC_URI="http://www.sptk.net/${P}.tbz2"

LICENSE="GPL-2 LGPL-2 LGPL-2.1"
SLOT="4"
KEYWORDS="~alpha amd64 ~mips ~ppc ~sparc ~x86"
IUSE="doc examples excel fltk mysql odbc pcre postgres sqlite ssl" # spell

# spell? ( >=app-text/aspell-0.60 )
RDEPEND="
	fltk? (
		>=media-libs/libpng-1.2:0
		sys-libs/zlib
		>=x11-libs/fltk-1.3.0:1
		)
	mysql? ( virtual/mysql )
	odbc? ( >=dev-db/unixODBC-2.3.0 )
	pcre? ( dev-libs/libpcre )
	postgres? ( >=dev-db/postgresql-base-8.0 )
	sqlite? ( >=dev-db/sqlite-3 )
	ssl? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS README"

src_configure() {
	# $(cmake-utils_use_no spell ASPELL)

	local mycmakeargs=(
		-DLIBDIR=$(get_libdir)
		-DNO_ASPELL=ON
		-DNO_EXAMPLES=ON
		$(cmake-utils_use_no excel)
		$(cmake-utils_use_no fltk)
		$(cmake-utils_use_no mysql)
		$(cmake-utils_use_no odbc)
		$(cmake-utils_use_no ssl OPENSSL)
		$(cmake-utils_use_no pcre)
		$(cmake-utils_use_no postgres POSTGRESQL)
		$(cmake-utils_use_no sqlite SQLITE3)
		)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	if use doc; then
		doxygen sptk4.doxygen
	fi
}

src_install () {
	cmake-utils_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r docs pictures
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r applications examples
	fi

	if [[ -e ${ED}/usr/bin/sql2cpp.pl ]]; then
		dosym sql2cpp.pl /usr/bin/sql2cpp
	fi
}
