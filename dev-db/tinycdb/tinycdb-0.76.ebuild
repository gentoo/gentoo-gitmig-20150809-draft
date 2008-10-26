# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tinycdb/tinycdb-0.76.ebuild,v 1.7 2008/10/26 15:26:09 hattya Exp $

inherit eutils toolchain-funcs

IUSE=""

DESCRIPTION="TinyCDB is a very fast and simple package for creating and reading constant data bases"
HOMEPAGE="http://www.corpit.ru/mjt/tinycdb.html"
SRC_URI="http://www.corpit.ru/mjt/${PN}/${P/-/_}.tar.gz"

RESTRICT="test"
LICENSE="public-domain"
KEYWORDS="~amd64 ~hppa ia64 ~ppc x86"
SLOT="0"

DEPEND="!dev-db/cdb"

src_compile() {

	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		staticlib \
		sharedlib \
		piclib \
		cdb-shared \
		|| die

}

src_install() {

	mv -f cdb-shared cdb

	einstall install-sharedlib install-piclib || die
	dodoc NEWS

}
