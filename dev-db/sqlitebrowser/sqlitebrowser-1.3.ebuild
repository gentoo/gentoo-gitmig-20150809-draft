# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlitebrowser/sqlitebrowser-1.3.ebuild,v 1.6 2009/02/03 15:11:55 drizzt Exp $

EAPI=1

inherit eutils qt3

DESCRIPTION="SQLite Database Browser"
HOMEPAGE="http://sqlitebrowser.sourceforge.net/"
SRC_URI="mirror://sourceforge/sqlitebrowser/${P}-src.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-db/sqlite-3*
	x11-libs/qt:3"

S="${WORKDIR}/${PN}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -r sqlite_source

	sed -i 's/\r/\n/g' *.{cpp,h}

	epatch "${FILESDIR}"/${P}-externalsqlite.patch
	# Don't use internal sqlite3 function wrt #227215
	epatch "${FILESDIR}"/${P}-sqlite-deprecated.patch
}

src_compile() {
	eqmake3
	emake || die "emake failed"
}

src_install() {
	dobin sqlitebrowser || die "installing failed"
}
