# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-closer-mop/cl-closer-mop-0.31.ebuild,v 1.1 2006/02/03 17:57:51 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Closer to MOP is a compatibility layer that rectifies many of the absent or incorrect MOP features as detected by MOP Feature Tests."
HOMEPAGE="http://common-lisp.net/project/closer/closer-mop.html"
SRC_URI="ftp://common-lisp.net/pub/project/closer/${P/cl-/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-lw-compat"

CLPACKAGE=closer-mop

S=${WORKDIR}/closer-mop

src_install() {
	common-lisp-install *.{asd,lisp}
	common-lisp-system-symlink
	for i in allegro clisp lispworks mcl pcl test; do
		insinto $CLSOURCEROOT/$CLPACKAGE/$i
		doins $i/*.lisp
	done
	dodoc *.txt
}
