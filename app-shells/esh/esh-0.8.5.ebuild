# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/esh/esh-0.8.5.ebuild,v 1.17 2008/12/30 20:43:29 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="A UNIX Shell with a simplified Scheme syntax"
HOMEPAGE="http://slon.ttk.ru/esh/"
SRC_URI="http://slon.ttk.ru/esh/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/readline-4.1"

S=${WORKDIR}/${PN}

src_compile() {
	sed -i \
		-e "/^CFLAGS/s/-g/${CFLAGS}/" \
		-e "s:^LIB=:LIB=-lncurses :" \
		-e "s:-ltermcap::" \
		Makefile
	# For some reason, this tarball has binary files in it for x86.
	# Make clean so we can rebuild for our arch and optimization.
	emake clean
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin esh || die
	doinfo doc/esh.info
	dodoc CHANGELOG CREDITS GC_README HEADER READLNE-HACKS TODO
	dohtml doc/*.html
	docinto examples
	dodoc examples/*
	insinto /usr/share/emacs/site-lisp/
	doins emacs/esh-mode.el
}
