# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freecdb/freecdb-0.62.ebuild,v 1.11 2004/10/02 06:14:16 usata Exp $

DESCRIPTION="A fast, reliable, simple package for creating and reading constant databases"
SRC_URI="mirror://debian/pool/main/f/freecdb//${P/-/_}.tar.gz"
HOMEPAGE="http://packages.qa.debian.org/f/freecdb.html"

SLOT="0"
PROVIDE="virtual/cdb"
LICENSE="public-domain"
KEYWORDS="x86 ppc sparc alpha amd64 ~ppc-macos"
IUSE=""

DEPEND="sys-devel/make
	dev-lang/perl"
RDEPEND=""

src_compile() {
	emake DESTDIR=${D} || die "make failed"
}

src_install() {
	dodir /usr/{lib,bin,include}
	dodir /usr/share/man/man{1,3}
	emake DESTDIR=${D} install || die

	dodoc README
}
