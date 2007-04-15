# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glimpse/glimpse-4.17.4.ebuild,v 1.12 2007/04/15 16:40:21 drac Exp $

inherit flag-o-matic eutils

DESCRIPTION="A index/query system to search a large set of files quickly"
HOMEPAGE="http://webglimpse.net/"
SRC_URI="http://webglimpse.net/trial/${P}.tar.gz"

LICENSE="glimpse"
SLOT="0"
KEYWORDS="mips"
IUSE="static"

RDEPEND="!dev-libs/tre
	!app-text/agrep"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gcc3.patch
	sed -i -e 's:-O3 -fomit-frame-pointer:$(OPTIMIZEFLAGS):' \
		dynfilters/Makefile.in \
		|| die "removing -O3 failed"
	sed -i -e '/^CFLAGS/s:$: $(OPTIMIZEFLAGS):' \
		{agrep,compress,index}/Makefile.in \
		Makefile.in \
		libtemplate/{template,util}/Makefile.in \
		|| die "inserting OPTIMIZEFLAGS failed"
}

src_compile() {
	use static && append-ldflags -static

	econf || die
	emake -j1 OPTIMIZEFLAGS="${CFLAGS}" || die
}

src_install() {
	einstall || die
	dodir /usr/share/man/man1
	mv "${D}"/usr/share/man/*.1 "${D}"/usr/share/man/man1/
}
