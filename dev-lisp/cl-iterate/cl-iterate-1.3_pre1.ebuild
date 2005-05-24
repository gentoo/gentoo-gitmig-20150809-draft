# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-iterate/cl-iterate-1.3_pre1.ebuild,v 1.3 2005/05/24 18:48:33 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="ITERATE is a lispy and extensible replacement for the Common Lisp LOOP macro"
HOMEPAGE="http://www.cliki.net/iterate
	http://boinkor.net/lisp/iterate/"
SRC_URI="http://common-lisp.net/project/iterate/releases/iterate-${PV/_/.}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

S=${WORKDIR}/iterate-${PV/_/.}

CLPACKAGE=iterate

src_install() {
	common-lisp-install *.lisp iterate.asd
	common-lisp-system-symlink
	dodoc BUGS ChangeLog README doc/*.ps
}
