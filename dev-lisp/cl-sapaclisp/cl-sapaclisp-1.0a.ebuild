# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-sapaclisp/cl-sapaclisp-1.0a.ebuild,v 1.1 2005/05/11 09:22:13 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION='Common-Lisp code for the book "Spectral Analysis for Physical Applications: Multitaper and Conventional Univariate Techniques"'
HOMEPAGE="http://common-lisp.net/project/sapaclisp/"
SRC_URI="http://common-lisp.net/project/sapaclisp/sapaclisp-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

S=${WORKDIR}/sapaclisp-${PV}

CLPACKAGE=sapaclisp

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc COPYING
}
