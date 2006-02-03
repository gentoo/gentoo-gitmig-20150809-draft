# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-contextl/cl-contextl-0.21.ebuild,v 1.1 2006/02/03 18:22:43 mkennedy Exp $

inherit common-lisp

DESCRIPTION="CLOS extension for context-oriented Programming"
HOMEPAGE="http://common-lisp.net/project/closer/"
SRC_URI="ftp://common-lisp.net/pub/project/closer/${P/cl-/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-lw-compat
	dev-lisp/cl-closer-mop"

CLPACKAGE=contextl

S=${WORKDIR}/contextl

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	insinto $CLSOURCEROOT/$CLPACKAGE/test
	doins test/*.lisp
}
