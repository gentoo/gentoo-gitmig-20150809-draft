# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-aspectl/cl-aspectl-0.70.ebuild,v 1.1 2006/02/03 18:26:41 mkennedy Exp $

inherit common-lisp

DESCRIPTION="AspectL is a library that provides aspect-oriented extensions for Common Lisp/CLOS."
HOMEPAGE="http://common-lisp.net/project/closer/"
SRC_URI="ftp://common-lisp.net/pub/project/closer/${P/cl-/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-contextl"

CLPACKAGE=aspectl

S=${WORKDIR}/aspectl

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	insinto $CLSOURCEROOT/$CLPACKAGE/tests
	doins tests/*.lisp
}
