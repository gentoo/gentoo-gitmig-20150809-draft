# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-phtml/cl-phtml-20030325.ebuild,v 1.1 2003/06/10 04:53:04 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp HTML parser which can be used with cl-htmlgen."
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
	cd ${S}
	patch -p1 <${FILESDIR}/phtml-gentoo.patch || die
	for i in *.cl ; do mv $i ${i/.cl/.lisp} ; done
}

src_install() {
	common-lisp-install phtml.lisp ${FILESDIR}/phtml.asd
	# phtml-test.lisp
	common-lisp-system-symlink 
	dodoc ChangeLog phtml.txt phtml.htm
}
