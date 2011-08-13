# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tinycdb/tinycdb-0.77.ebuild,v 1.7 2011/08/13 12:19:01 hattya Exp $

EAPI="4"

inherit eutils multilib toolchain-funcs

DESCRIPTION="TinyCDB is a very fast and simple package for creating and reading constant data bases"
HOMEPAGE="http://www.corpit.ru/mjt/tinycdb.html"
SRC_URI="http://www.corpit.ru/mjt/${PN}/${P/-/_}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc x86"
IUSE=""
RESTRICT="test"

RDEPEND="!dev-db/cdb"

src_prepare() {
	# fix multilib support
	sed -i "/^libdir/s:/lib:/$(get_libdir):" Makefile
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} ${LDFLAGS}" \
		staticlib \
		sharedlib \
		piclib \
		cdb-shared
	mv -f cdb-shared cdb
}

src_install() {
	einstall install-sharedlib install-piclib
	dodoc NEWS
}
