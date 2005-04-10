# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-memoization/cl-memoization-20050302.ebuild,v 1.1 2005/04/10 21:44:07 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Memoization support to CMU Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/libs/cl-memoization"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-memoization/${PN}_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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
