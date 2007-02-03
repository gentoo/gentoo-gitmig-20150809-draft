# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-memoization/cl-memoization-20050302.ebuild,v 1.4 2007/02/03 17:37:06 flameeyes Exp $

inherit common-lisp

DESCRIPTION="Memoization support to CMU Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/libs/cl-memoization"
SRC_URI="mirror://debian/pool/main/c/cl-memoization/${PN}_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=memoization

S=${WORKDIR}/t

src_unpack() {
	unpack ${A}
	rm ${S}/Makefile || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc docs/*.{ps,text} docs/README Memo-Tables/fib.lisp
	do-debian-credits
}
