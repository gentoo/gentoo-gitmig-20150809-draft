# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xml/cl-xml-2-r1.ebuild,v 1.1 2004/02/12 09:13:21 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Simple XML Parser for Common Lisp"
HOMEPAGE="http://homepage.mac.com/svc/xml/readme.html"
SRC_URI="mirror://gentoo/xml-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

S=${WORKDIR}/xml

CLPACKAGE='xml-parser-only xml'

src_install() {
	insinto /usr/share/common-lisp/source/xml
	doins *.asd *.lisp
	dodir /usr/share/common-lisp/systems
	for package in ${CLPACKAGE}; do
		dosym /usr/share/common-lisp/source/xml/${package}.asd \
			/usr/share/common-lisp/systems/${package}.asd
	done
	dohtml *.html
	insinto /usr/share/common-lisp/source/${CLPACKAGE}/test
	doins test/*.{lisp,xml}
}
