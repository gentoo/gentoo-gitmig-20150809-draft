# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-dot/cl-dot-0.1.ebuild,v 1.1 2005/11/23 18:27:00 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp library for generating output for the Graphviz dot program"
HOMEPAGE="http://www.cliki.net/cl-dot"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-gfx/graphviz"

CLPACKAGE=cl-dot

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc README COPYING
	insinto $CLSOURCEROOT/$CLPACKAGE/examples
	doins examples/*.lisp
}
