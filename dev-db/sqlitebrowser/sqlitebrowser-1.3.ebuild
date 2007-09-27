# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlitebrowser/sqlitebrowser-1.3.ebuild,v 1.4 2007/09/27 19:20:34 drizzt Exp $

inherit eutils qt3

DESCRIPTION="SQLite Database Browser"
HOMEPAGE="http://sqlitebrowser.sourceforge.net/"
SRC_URI="mirror://sourceforge/sqlitebrowser/${P}-src.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-db/sqlite-3*
	$(qt_min_version 3.1.2)"

S="${WORKDIR}/${PN}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -r sqlite_source

	sed -i 's/\r/\n/g' *.{cpp,h}

	# I hate qt designer!
	has_version "=x11-libs/qt-3.3*" && sed -i '1s/UI version="3.2"/UI version="3.3"/'

	epatch "${FILESDIR}"/${P}-externalsqlite.patch
}

src_compile() {
	eqmake3
	emake || die "emake failed"
}

src_install() {
	dobin sqlitebrowser || die "installing failed"
}
