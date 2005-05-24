# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ubf/cl-ubf-0.2.1-r1.ebuild,v 1.4 2005/05/24 18:48:36 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp implementation of a UBF(A) reader and writer"
HOMEPAGE="http://common-lisp.net/project/ubf/
	http://www.cliki.net/ubf
	http://www.sics.se/~joe/ubf/site/home.html"
SRC_URI="http://common-lisp.net/project/ubf/releases/ubf-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=ubf

S=${WORKDIR}/ubf-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
}
