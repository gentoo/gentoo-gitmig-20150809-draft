# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-irc/cl-irc-0.5.0-r1.ebuild,v 1.1 2004/02/12 09:13:14 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp IRC client library"
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
	docinto doc
	dodoc doc/*.txt
	docinto examples
	dodoc example/*.lisp example/Mop_Sym.txt
}
