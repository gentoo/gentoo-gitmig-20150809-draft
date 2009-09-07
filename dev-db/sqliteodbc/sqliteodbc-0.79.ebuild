# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqliteodbc/sqliteodbc-0.79.ebuild,v 1.5 2009/09/07 22:23:26 arfrever Exp $

inherit eutils autotools

DESCRIPTION="ODBC driver to access local SQLite database files."

HOMEPAGE="http://www.ch-werner.de/sqliteodbc/"
SRC_URI="http://www.ch-werner.de/sqliteodbc/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="sqlite static"

DEPEND="
	>=dev-db/sqlite-2.8.16
	|| (
		>=dev-db/unixODBC-2.2
		>=dev-db/libiodbc-3.5
	)
	sqlite? ( >=dev-db/sqlite-3.5 )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.77-iodbc.patch"
	eautoconf
}

src_compile() {
	econf $(use_enable static)
	emake || die "could not compile"
}

src_install() {
	dodir /usr/$(get_libdir)
	einstall || die "could not install"
	dodoc README ChangeLog
}
