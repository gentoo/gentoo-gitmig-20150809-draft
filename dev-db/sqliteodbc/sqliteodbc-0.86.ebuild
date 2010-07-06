# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqliteodbc/sqliteodbc-0.86.ebuild,v 1.2 2010/07/06 21:07:11 hwoarang Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="ODBC driver to access local SQLite database files."
HOMEPAGE="http://www.ch-werner.de/sqliteodbc/"
SRC_URI="http://www.ch-werner.de/sqliteodbc/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-db/sqlite-3.6
	|| (
		>=dev-db/unixODBC-2.2
		>=dev-db/libiodbc-3.5
	)"
RDEPEND="${DEPEND}"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.83-respect_LDFLAGS.patch"
}

src_install() {
	dodir "/usr/$(get_libdir)"
	einstall || die "einstall failed"
	dodoc ChangeLog README
}
