# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-yacc/cl-yacc-0.1.ebuild,v 1.1 2005/04/25 02:19:41 mkennedy Exp $

inherit common-lisp

DESCRIPTION="CL-YACC is a LALR(1) parser generator for Common Lisp"
HOMEPAGE="http://www.pps.jussieu.fr/~jch/software/cl-yacc/
	http://www.cliki.net/CL-Yacc"
SRC_URI="http://www.pps.jussieu.fr/~jch/software/files/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE="doc"
DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller
	doc? ( sys-apps/texinfo )"

CLPACKAGE="yacc"

src_compile() {
	if use doc; then
		makeinfo cl-yacc.texi || die
	fi
}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	use doc && doinfo *.info*
	dodoc README COPYING
}
