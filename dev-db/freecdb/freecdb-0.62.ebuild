# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freecdb/freecdb-0.62.ebuild,v 1.17 2008/01/26 19:02:58 grobian Exp $

KEYWORDS="alpha amd64 ppc sparc x86"

DESCRIPTION="A fast, reliable, simple package for creating and reading constant databases."
SRC_URI="mirror://debian/pool/main/f/freecdb//${P/-/_}.tar.gz"
HOMEPAGE="http://packages.qa.debian.org/f/freecdb.html"
LICENSE="public-domain"
SLOT="0"
IUSE=""

DEPEND="dev-lang/perl
		!dev-db/cdb
		!dev-db/tinycdb"
RDEPEND="${DEPEND}"

src_compile() {
	emake DESTDIR="${D}" || die "emake failed"
}

src_install() {
	dodir /usr/{lib,bin,include} /usr/share/man/man{1,3}
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
