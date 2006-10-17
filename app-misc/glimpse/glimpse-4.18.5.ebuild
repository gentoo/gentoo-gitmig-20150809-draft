# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glimpse/glimpse-4.18.5.ebuild,v 1.6 2006/10/17 18:03:10 gustavoz Exp $

inherit flag-o-matic eutils

DESCRIPTION="A index/query system to search a large set of files quickly"
HOMEPAGE="http://webglimpse.net/"
SRC_URI="http://webglimpse.net/trial/${P}.tar.gz"

LICENSE="glimpse"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ~mips ~ppc ~ppc-macos ~ppc64 sparc x86"
IUSE="static"

RDEPEND="!dev-libs/tre
	!app-text/agrep
	virtual/libc"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:CC=.*:CC=$(tc-getCC):" \
		-e 's:-O3 -fomit-frame-pointer:$(OPTIMIZEFLAGS):' \
		dynfilters/Makefile.in \
		|| die "removing -O3 failed"
	sed -i \
		-e '/^CFLAGS/s:$: $(OPTIMIZEFLAGS):' \
		{agrep,compress,index}/Makefile.in \
		Makefile.in \
		libtemplate/{template,util}/Makefile.in \
		|| die "inserting OPTIMIZEFLAGS failed"
	sed -i \
		-e 's:$(mandir):&/man1/:' \
		Makefile.in agrep/Makefile.in \
		|| die "adding man1 to man install dir failed"
}

src_compile() {
	use static && append-ldflags -static

	econf || die
	emake -j1 OPTIMIZEFLAGS="${CFLAGS}" || die
}

src_install() {
	einstall || die
}
