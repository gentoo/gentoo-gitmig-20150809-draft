# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/clisp/clisp-2.29.ebuild,v 1.7 2004/03/30 20:58:13 spyderous Exp $

IUSE="X"

DESCRIPTION="A portable, bytecode-compiled implementation of Common Lisp"
HOMEPAGE="http://clisp.sourceforge.net/"
SRC_URI="http://cvs2.cons.org/ftp-area/clisp/source/latest/${P}.tar.gz"
S=${WORKDIR}/${PN}
DEPEND="X? ( virtual/x11 )"
RDEPEND="$DEPEND"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ~ppc"

src_compile() {
	local myconf="--with-dynamic-ffi --with-dynamic-modules --with-export-syscalls --with-module=wildcard --with-module=regexp --with-module=bindings/linuxlibc6"
	if [ -n "`use X`" ] ; then
		myconf="${myconf} --with-module=clx/new-clx"
	fi

	# compilation of modules fails if we don't do this (mkennedy: yep
	# -- confirmed on gcc3.2 too)

	unset CHOST
	unset CFLAGS
	unset CXXFLAGS

	./configure --prefix=/usr ${myconf} || die "./configure failed"
	cd src
	./makemake ${myconf} > Makefile
	make config.lisp

	# 2002-09-26: karltk
	# Not emake-safe
	make || die
}

src_install () {
	cd src
	make DESTDIR=${D} prefix=/usr install-bin || die
	install -Dm 644 clisp.1 ${D}/usr/share/man/man1/clisp.1
	install -Dm 644 clreadline.3 ${D}/usr/share/man/man3/clreadline.3
	dodoc SUMMARY README* NEWS MAGIC.add GNU-GPL COPYRIGHT ANNOUNCE clisp.dvi clisp.html clreadline.dvi clreadline.html
}

