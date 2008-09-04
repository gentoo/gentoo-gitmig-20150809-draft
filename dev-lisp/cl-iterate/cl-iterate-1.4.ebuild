# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-iterate/cl-iterate-1.4.ebuild,v 1.3 2008/09/04 06:17:02 opfer Exp $

inherit common-lisp eutils

DESCRIPTION="ITERATE is a lispy and extensible replacement for the Common Lisp LOOP macro"
HOMEPAGE="http://common-lisp.net/project/iterate/
	http://www.cliki.net/iterate"
SRC_URI="http://common-lisp.net/project/iterate/releases/iterate_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller
	doc? ( virtual/latex-base )"

S=${WORKDIR}/iterate_${PV}

CLPACKAGE=iterate

src_compile() {
	use doc && make -C doc
}

src_install() {
	common-lisp-install *.lisp iterate.asd
	common-lisp-system-symlink
	dodoc BUGS ChangeLog README
	use doc && dodoc doc/*.ps
}
