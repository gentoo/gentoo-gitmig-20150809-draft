# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freecdb/freecdb-0.62.ebuild,v 1.1 2003/05/05 08:28:53 phosphan Exp $

DESCRIPTION="A fast, reliable, simple package for creating and reading constant databases"
SRC_URI="http://ftp.debian.org/debian/pool/main/f/freecdb//${P/-/_}.tar.gz"
HOMEPAGE="http://packages.qa.debian.org/f/freecdb.html"

SLOT="0"
PROVIDE="virtual/cdb"
LICENSE="public-domain"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="sys-devel/make
	dev-lang/perl"
RDEPEND=""

src_compile() {                           
	emake DESTDIR=${D} || die "make failed"
}

src_install() {                               
	mkdir -p ${D}/usr/{lib,bin,include}
	mkdir -p ${D}/usr/share/man/man{1,3}
	emake DESTDIR=${D} install

	dodoc README
}
