# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-phtml/cl-phtml-20030325.ebuild,v 1.3 2003/10/16 14:59:59 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp HTML parser from Franz, Inc. which can be used with cl-htmlgen."
HOMEPAGE="http://opensource.franz.com/xmlutils/index.html"
SRC_URI="mirror://gentoo/xmlutils-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-acl-compat"

CLPACKAGE=phtml

S=${WORKDIR}/xmlutils

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/phtml-${PV}-gentoo.patch
}

src_install() {
	common-lisp-install phtml.cl ${FILESDIR}/phtml.asd
	common-lisp-system-symlink
	dodoc ChangeLog phtml.txt phtml.htm
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
