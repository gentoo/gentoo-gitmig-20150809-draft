# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pbzip2/pbzip2-0.8.ebuild,v 1.2 2004/11/15 18:46:04 wolf31o2 Exp $

inherit gcc flag-o-matic

DESCRIPTION="A parallel version of BZIP2"
HOMEPAGE="http://compression.ca/${PN}/"
SRC_URI="http://compression.ca/${PN}/${P}.tar.gz"

LICENSE="PBZIP2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="static"

DEPEND="virtual/libc
	app-arch/bzip2"

src_unpack() {
	unpack ${A}
	sed -i -e 's:-O3:${CFLAGS}:g' ${P}/Makefile || die
}

src_compile() {
	if use static; then
		make pbzip2-static
	else
		make pbzip2
	fi
}

src_install() {
	dobin pbzip2
	dodoc *.txt
}
