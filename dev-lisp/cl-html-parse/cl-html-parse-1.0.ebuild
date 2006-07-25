# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-html-parse/cl-html-parse-1.0.ebuild,v 1.1 2006/07/25 04:49:26 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A parser that parses HTML documents and generates a sexp-based representation."
HOMEPAGE="http://www.cl-user.net/asp/libs/cl-html-parse
	http://www.cliki.net/CL-HTML-Parse"
SRC_URI="mirror://gentoo/${PN}_${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

CLPACKAGE=cl-html-parse

S=${WORKDIR}/${PN}

src_install() {
	insinto $CLSOURCEROOT/$CLPACKAGE/dev
	doins dev/*.lisp
	common-lisp-install *.asd
	common-lisp-system-symlink
	dohtml -r dev/examples
	dodoc COPYING dev/README
}
