# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmba/libmba-0.9.1.ebuild,v 1.3 2007/07/12 02:25:35 mr_bones_ Exp $

DESCRIPTION="A library of generic C modules."
HOMEPAGE="http://www.ioplex.com/~miallen/libmba/"
SRC_URI="http://www.ioplex.com/~miallen/libmba/dl/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	rm Makefile.linux
}

src_compile() {
	# Parallel make fails unless mktool is built first
	emake -j1 mktool || die "Unable to build mktool"

	# Makefile uses MFLAGS, not CFLAGS
	# Additional MFLAGS are from Makefile and are required
	emake MFLAGS="-Isrc -W1 ${CFLAGS}" || die "emake failed"
}

src_install() {
	# einstall is required here. No DESTDIR support
	einstall || die "Install failed!"

	dodoc README.txt docs/*.txt || die
	dohtml -r docs/*.html docs/www/* docs/ref || die

	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
