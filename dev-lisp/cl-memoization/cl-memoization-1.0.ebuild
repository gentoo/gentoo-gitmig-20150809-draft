# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-memoization/cl-memoization-1.0.ebuild,v 1.1 2004/10/15 03:52:11 mkennedy Exp $

inherit common-lisp

DEB_PV=9

DESCRIPTION="Memoization support to CMU Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/libs/cl-memoization"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/${PN}/${PN}_${PV}-${DEB_PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=memoization

S=${WORKDIR}/memoization-${PV}

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
