# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlitebrowser/sqlitebrowser-1.3.ebuild,v 1.2 2007/02/13 17:33:24 peper Exp $

inherit eutils qt3

DESCRIPTION="SQLite Database Browser"
HOMEPAGE="http://sqlitebrowser.sourceforge.net/"
SRC_URI="mirror://sourceforge/sqlitebrowser/${P}-src.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-db/sqlite-3*
	$(qt_min_version 3.12)"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -r sqlite_source

	sed -i 's/\r/\n/g' *.{cpp,h}
	epatch "${FILESDIR}"/${P}-externalsqlite.patch
}

src_compile() {
	qmake ${PN}.pro || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin sqlitebrowser || die "installing failed"
}
