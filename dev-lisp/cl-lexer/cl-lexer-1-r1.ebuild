# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-lexer/cl-lexer-1-r1.ebuild,v 1.1 2004/02/12 09:13:14 mkennedy Exp $

inherit common-lisp

DEB_PV=2

DESCRIPTION="Lexical-analyzer-generator package for Common Lisp"
HOMEPAGE="http://www.geocities.com/mparker762/clawk.html
	http://packages.debian.org/unstable/devel/cl-lexer.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-lexer/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-lexer/${PN}_${PV}-${DEB_PV}.diff.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-regex"

CLPACKAGE=lexer

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install lexer.lisp packages.lisp lexer.asd
	common-lisp-system-symlink
	dodoc license.txt
	docinto examples
	dodoc example.lisp
	do-debian-credits
}
