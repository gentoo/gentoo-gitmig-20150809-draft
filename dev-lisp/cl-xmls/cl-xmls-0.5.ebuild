# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xmls/cl-xmls-0.5.ebuild,v 1.3 2004/06/24 23:57:17 agriffis Exp $

inherit common-lisp

DESCRIPTION=" Xmls is a small, simple, non-validating xml parser for Common Lisp. It's designed to be a self-contained, easily embedded parser that recognizes a useful subset of the XML spec. It provides a simple mapping from xml to lisp s-expressions and back."
HOMEPAGE="http://www.caddr.com/lisp/xmls/
	http://www.cliki.net/xmls"
SRC_URI="http://www.caddr.com/lisp/xmls/xmls-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=xmls

S=${WORKDIR}/xmls-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc Changelog COPYING
	dohtml README.html
	cp -r tests ${D}/usr/share/doc/${P}/
	dodoc run-tests.sh
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
