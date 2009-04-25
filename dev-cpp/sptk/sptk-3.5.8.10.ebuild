# Copyright 2006-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-3.5.8.10.ebuild,v 1.5 2009/04/25 12:35:22 iluxa Exp $

EAPI=1

inherit eutils flag-o-matic multilib

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
	dev-util/cmake
	doc?      ( app-doc/doxygen )"

sptk_use_enable() {
	if use ${1}; then
		SPTK_OPTIONS="${SPTK_OPTIONS} -DNO_${2}:BOOLEAN=FALSE"
	else
		SPTK_OPTIONS="${SPTK_OPTIONS} -DNO_${2}:BOOLEAN=TRUE"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	sptk_use_enable postgres POSTGRESQL
	sptk_use_enable mysql    MYSQL
	sptk_use_enable sqlite   SQLITE3
	sptk_use_enable odbc     ODBC
	sptk_use_enable aspell   ASPELL
	sptk_use_enable fltk     FLTK
	sptk_use_enable excel    EXCEL

	cmake -D CMAKE_INSTALL_PREFIX:PATH=/usr -D LIBDIR=$(get_libdir) ${SPTK_OPTIONS} -DNO_EXAMPLES:BOOLEAN=TRUE .  || die "Configuration Failed"

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

	emake DESTDIR="${D}" install || die "Installation failed"

	dodoc README AUTHORS

	dodir /usr/share/doc/${PF}
	cp -r "${S}"/docs/* "${D}"/usr/share/doc/${PF}
	if use doc; then
		rm -fr "${D}/usr/share/doc/${PF}/latex"
		cp -rf "${S}/pictures" "${D}/usr/share/doc/${PF}"
	fi
}
