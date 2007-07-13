# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqliteodbc/sqliteodbc-0.64.ebuild,v 1.4 2007/07/13 06:38:59 mr_bones_ Exp $

inherit eutils

DESCRIPTION="ODBC driver to access local SQLite database files."

HOMEPAGE="http://www.ch-werner.de/sqliteodbc/"
SRC_URI="http://www.ch-werner.de/sqliteodbc/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=dev-db/sqlite-2*
	|| (
		>=dev-db/unixODBC-2
		>=dev-db/libiodbc-3.0.6
	)"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	econf --disable-static || die "could not configure"
	emake || die "could not compile"
}

src_install() {
	dodir /usr/lib
	einstall || die "could not install"
}
