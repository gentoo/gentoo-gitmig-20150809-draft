# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqliteodbc/sqliteodbc-0.64-r1.ebuild,v 1.2 2007/07/13 06:38:59 mr_bones_ Exp $

inherit eutils

DESCRIPTION="ODBC driver to access local SQLite database files."

HOMEPAGE="http://www.ch-werner.de/sqliteodbc/"
SRC_URI="http://www.ch-werner.de/sqliteodbc/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="sqlite sqlite3"

DEPEND="sqlite? ( =dev-db/sqlite-2* )
	sqlite3? ( =dev-db/sqlite-3* )
	|| (
		>=dev-db/unixODBC-2
		>=dev-db/libiodbc-3.0.6
	)"

pkg_setup() {
	if use !sqlite && use !sqlite3
	then
		eerror "Please select at least one sqlite library to link against"
		exit 1
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	if use !sqlite
	then
		myconf="${myconf} $(use_with sqlite)"
	fi
	if use !sqlite3
	then
		myconf="${myconf} $(use_with sqlite3)"
	fi
	econf --disable-static ${myconf} || die "could not configure"
	emake || die "could not compile"
}

src_install() {
	dodir /usr/lib
	einstall || die "could not install"
}
