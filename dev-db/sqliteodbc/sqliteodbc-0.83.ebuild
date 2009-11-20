# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqliteodbc/sqliteodbc-0.83.ebuild,v 1.4 2009/11/20 15:05:05 maekke Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="ODBC driver to access local SQLite database files."
HOMEPAGE="http://www.ch-werner.de/sqliteodbc/"
SRC_URI="http://www.ch-werner.de/sqliteodbc/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
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
	epatch "${FILESDIR}/${P}-respect_LDFLAGS.patch"
}

src_install() {
	dodir "/usr/$(get_libdir)"
	einstall || die "einstall failed"
	dodoc ChangeLog README
}
