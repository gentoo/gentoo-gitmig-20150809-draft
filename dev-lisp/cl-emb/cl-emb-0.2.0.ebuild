# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-emb/cl-emb-0.2.0.ebuild,v 1.1 2004/11/07 21:40:22 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Embedded Common Lisp and template system"
HOMEPAGE="http://common-lisp.net/project/cl-emb/"
# SRC_URI="http://common-lisp.net/project/cl-emb/cl-emb-${PV}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/cl-ppcre"

CLPACKAGE=cl-emb

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dohtml examples.html
	dodoc TODO LICENSE.txt lsp-LICENSE.txt README
}
