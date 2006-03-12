# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-lexer/cl-lexer-20060228.ebuild,v 1.1 2006/03/12 18:36:11 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Lexical-analyzer-generator package for Common Lisp"
HOMEPAGE="http://www.geocities.com/mparker762/clawk.html
	http://www.cl-user.net/asp/libs/tputils-lexer"
SRC_URI="mirror://gentoo/lexer-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-regex"

S=$WORKDIR/

CLPACKAGE=lexer

src_install() {
	common-lisp-install {lexer,packages}.lisp $FILESDIR/lexer.asd
	common-lisp-system-symlink
	dodoc license.txt
}
