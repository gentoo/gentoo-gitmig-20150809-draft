# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freecdb/freecdb-0.62.ebuild,v 1.15 2006/11/22 18:59:54 masterdriverz Exp $

DESCRIPTION="A fast, reliable, simple package for creating and reading constant databases"
SRC_URI="mirror://debian/pool/main/f/freecdb//${P/-/_}.tar.gz"
HOMEPAGE="http://packages.qa.debian.org/f/freecdb.html"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ppc-macos"
IUSE=""

DEPEND="sys-devel/make
	dev-lang/perl
	!dev-db/cdb"
RDEPEND=""

src_compile() {
	emake DESTDIR="${D}" || die "emake failed"
}

src_install() {
	dodir /usr/{lib,bin,include} /usr/share/man/man{1,3}
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
