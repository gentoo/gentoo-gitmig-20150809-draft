# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-lexer/cl-lexer-1-r1.ebuild,v 1.8 2007/02/03 17:36:01 flameeyes Exp $

inherit common-lisp eutils

DEB_PV=2

DESCRIPTION="Lexical-analyzer-generator package for Common Lisp"
HOMEPAGE="http://www.geocities.com/mparker762/clawk.html http://packages.debian.org/unstable/devel/cl-lexer.html"
SRC_URI="mirror://debian/pool/main/c/cl-lexer/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/c/cl-lexer/${PN}_${PV}-${DEB_PV}.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/cl-regex"

CLPACKAGE=lexer

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install lexer.lisp packages.lisp lexer.asd
	common-lisp-system-symlink
	dodoc license.txt
	docinto examples
	dodoc example.lisp
	do-debian-credits
}
