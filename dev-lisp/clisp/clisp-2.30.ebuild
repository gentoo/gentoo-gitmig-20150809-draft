# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/clisp/clisp-2.30.ebuild,v 1.2 2004/03/30 20:58:13 spyderous Exp $

IUSE="X threads"

DESCRIPTION="A portable, bytecode-compiled implementation of Common Lisp"
HOMEPAGE="http://clisp.sourceforge.net/"
SRC_URI="mirror://sourceforge/clisp/${P}.tar.bz2"
S=${WORKDIR}/${P}
DEPEND="X? ( virtual/x11 )"
RDEPEND="$DEPEND"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc"

src_unpack() {
	unpack ${A}
	cd ${S} && patch -p1 <${FILESDIR}/${P}-gentoo.patch || die
	cd ${S} && patch -p2 <${FILESDIR}/${P}-linux.lisp-upstream.patch || die
}

src_compile() {
	local myconf="--with-dynamic-ffi
		--with-dynamic-modules
		--with-export-syscalls
		--with-module=wildcard
		--with-module=regexp
		--with-module=bindings/linuxlibc6"

# for the time being, these modules cause segv during build
#	use X && myconf="${myconf} --with-module=clx/new-clx"
# 	use threads && myconf="${myconf} --with-threads=POSIX_THREADS"

	einfo "Configuring with $myconf"
	./configure --prefix=/usr ${myconf} || die "./configure failed"
	cd src && ./makemake ${myconf} > Makefile
	make config.lisp
	make || die
}

src_install () {
	cd src && make DESTDIR=${D} prefix=/usr install-bin || die
	doman clisp.1 clreadline.3
	dodoc SUMMARY README* NEWS MAGIC.add GNU-GPL COPYRIGHT \
		ANNOUNCE clisp.dvi clisp.html clreadline.dvi clreadline.html
}
