# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-irc/cl-irc-0.5.0.ebuild,v 1.4 2004/07/14 15:51:07 agriffis Exp $

inherit common-lisp

DESCRIPTION="cl-irc is a Common Lisp IRC client library."
HOMEPAGE="http://common-lisp.net/project/cl-irc/"
SRC_URI="ftp://common-lisp.net/pub/project/cl-irc/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
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


pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
