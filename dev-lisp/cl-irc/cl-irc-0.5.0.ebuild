# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-irc/cl-irc-0.5.0.ebuild,v 1.1 2004/02/01 19:17:06 mkennedy Exp $

inherit common-lisp

DESCRIPTION="cl-irc is a Common Lisp IRC client library."
HOMEPAGE="http://common-lisp.net/project/cl-irc/"
SRC_URI="ftp://common-lisp.net/pub/project/cl-irc/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-split-sequence"

CLPACKAGE=cl-irc
S=${WORKDIR}/${PN}

src_install() {
	common-lisp-install cl-irc.asd *.lisp
	common-lisp-system-symlink
	dodoc CREDITS LICENSE README TODO
	docinto /usr/share/doc/$PF/doc
	dodoc doc/*.txt
	docinto /usr/share/doc/$PF/examples
	dodoc example/*.lisp example/Mop_Sym.txt
}


pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
