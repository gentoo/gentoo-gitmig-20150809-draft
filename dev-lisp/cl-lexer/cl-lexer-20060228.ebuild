# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-lexer/cl-lexer-20060228.ebuild,v 1.2 2009/12/15 19:35:17 ssuominen Exp $

inherit common-lisp eutils

DESCRIPTION="Lexical-analyzer-generator package for Common Lisp"
HOMEPAGE="http://www.cl-user.net/asp/libs/tputils-lexer"
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
