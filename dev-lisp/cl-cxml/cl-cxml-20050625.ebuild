# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-cxml/cl-cxml-20050625.ebuild,v 1.1 2005/12/09 20:12:59 mkennedy Exp $

inherit common-lisp

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="A Common Lisp XML library implementing namespaces, a validating SAX-like XML 1.0 parser and the DOM Level 1 Core interfaces."
HOMEPAGE="http://common-lisp.net/project/cxml/"
SRC_URI="http://common-lisp.net/project/cxml/download/cxml-${MY_PV}.tgz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-puri"

CLPACKAGE='cxml cxml-contrib'

S=${WORKDIR}/cxml-${MY_PV}

src_unpack() {
	unpack ${A}
	rm ${S}/GNUmakefile
}

src_install() {
	insinto $CLSOURCEROOT/cxml
	doins *.{dtd,asd} $FILESDIR/cxml-contrib.asd
	insinto $CLSOURCEROOT/cxml/runes
	doins runes/*.lisp
	insinto $CLSOURCEROOT/cxml/xml
	doins xml/*.lisp
	insinto $CLSOURCEROOT/cxml/xml/sax-tests
	doins xml/sax-tests/*.lisp
	insinto $CLSOURCEROOT/cxml/test
	doins test/*.lisp
	insinto $CLSOURCEROOT/cxml/contrib
	doins contrib/*.lisp
	insinto $CLSOURCEROOT/cxml/dom
	doins dom/*.lisp
	dodir $CLSYSTEMROOT
	dosym $CLSOURCEROOT/cxml/cxml.asd $CLSYSTEMROOT/
	dosym $CLSOURCEROOT/cxml/cxml-contrib.asd $CLSYSTEMROOT/
	dodoc OLDNEWS TIMES
	dohtml *.{html,css}
	dohtml -r doc
}
