# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xml/cl-xml-2.ebuild,v 1.1 2004/01/10 03:59:12 mkennedy Exp $

inherit common-lisp

DESCRIPTION=" A Simple XML Parser for Common Lisp"
HOMEPAGE="http://homepage.mac.com/svc/xml/readme.html"
SRC_URI="mirror://gentoo/xml-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

S=${WORKDIR}/xml

CLPACKAGE=xml

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dohtml *.html
	insinto /usr/share/common-lisp/source/${CLPACKAGE}/test
	doins test/*.{lisp,xml}
}


pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postinst() {
	while read line; do einfo ${line}; done <<EOF

You can test ${PN} by issuing the following commands in your favourite
Common Lisp implementation:

	(require :xml)
	(load "/usr/share/common-lisp/source/xml/test/all-tests.lisp")

EOF
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
