# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/esh/esh-0.8-r2.ebuild,v 1.16 2004/06/29 03:54:48 vapier Exp $

DESCRIPTION="A UNIX Shell with a simplified Scheme syntax"
HOMEPAGE="http://esh.netpedia.net/"
SRC_URI="http://esh.netpedia.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.1
	>=sys-libs/readline-4.1"

S=${WORKDIR}/${PN}

src_compile() {
	sed -i \
		-e "s:^CFLAGS=:CFLAGS=${CFLAGS/-fomit-frame-pointer/} :" \
		-e "s:^LIB=:LIB=-lncurses :" Makefile
	make || die
}

src_install() {
	dobin esh || die
	doinfo doc/esh.info
	dodoc CHANGELOG CREDITS GC_README HEADER READLNE-HACKS TODO
	docinto html
	dodoc doc/*.html
	docinto examples
	dodoc examples/*
	insinto /usr/share/emacs/site-lisp/
	doins emacs/esh-mode.el
}
