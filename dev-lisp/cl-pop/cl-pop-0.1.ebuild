# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pop/cl-pop-0.1.ebuild,v 1.1 2006/07/30 01:59:39 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp client library for RFC1939 (POP3) networking protocol."
HOMEPAGE="http://common-lisp.net/project/cl-pop/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-smtp
	dev-lisp/cl-ppcre"

CLPACKAGE=cl-pop

S=${WORKDIR}/${PN}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dohtml *.html
	dodoc *LICENSE *.txt
}
