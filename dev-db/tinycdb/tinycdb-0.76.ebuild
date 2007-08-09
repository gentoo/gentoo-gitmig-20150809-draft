# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tinycdb/tinycdb-0.76.ebuild,v 1.3 2007/08/09 10:02:44 hattya Exp $

inherit eutils

IUSE=""

DESCRIPTION="TinyCDB is a very fast and simple package for creating and reading constant data bases"
HOMEPAGE="http://www.corpit.ru/mjt/tinycdb.html"
SRC_URI="http://www.corpit.ru/mjt/${PN}/${P/-/_}.tar.gz"

LICENSE="public-domain"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc x86"
SLOT="0"

DEPEND="!dev-db/cdb
	!dev-db/freecdb"

src_compile() {

	emake staticlib sharedlib piclib cdb-shared || die
	mv -f cdb-shared cdb

}

src_install() {

	einstall install-sharedlib install-piclib || die
	dodoc NEWS

}
