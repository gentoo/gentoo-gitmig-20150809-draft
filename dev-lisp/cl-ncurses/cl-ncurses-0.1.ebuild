# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ncurses/cl-ncurses-0.1.ebuild,v 1.2 2004/04/21 17:01:01 vapier Exp $

inherit common-lisp eutils

DESCRIPTION="CL-NCURSES is a NCURSES interface for Common Lisp on Unix-platforms."
HOMEPAGE="http://www.common-lisp.net/project/cl-ncurses/"
SRC_URI="http://common-lisp.net/project/cl-ncurses/files/cl-ncurses_${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-ncurses

S=${WORKDIR}/cl-ncurses_${PV}

src_unpack() {
	unpack ${A}
	cd ${S} && epatch ${FILESDIR}/cl-ncurses-${PV}-gentoo.patch
}

src_compile() {
	make || die
}

src_install() {
	common-lisp-install *.lisp cl-ncurses.asd
	common-lisp-system-symlink
	dodoc README
	exeinto /usr/lib/cl-ncurses
	doexe glue.so
	insinto ${CLSOURCEROOT}/${PN}/tests
	doins tests/*
}
