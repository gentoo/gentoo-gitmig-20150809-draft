# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pxml/cl-pxml-20030325.ebuild,v 1.4 2003/10/16 17:37:11 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp XML parser from Franz, Inc."
HOMEPAGE="http://opensource.franz.com/xmlutils/index.html"
SRC_URI="mirror://gentoo/xmlutils-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="-x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-acl-compat"

CLPACKAGE=pxml

S=${WORKDIR}/xmlutils

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/pxml-${PV}-gentoo.patch
}

src_install() {
	common-lisp-install pxml?.cl ${FILESDIR}/pxml.asd
	common-lisp-system-symlink
	dodoc ChangeLog pxml.txt pxml.htm
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
