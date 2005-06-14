# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-defpatt/cl-defpatt-0.2.1.ebuild,v 1.1 2005/06/14 17:50:27 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A mechanism for defining and using pattern abstractions with CL-PPCRE"
HOMEPAGE="http://www.cliki.net/defpatt
	http://www.harbo.net/downloads/"
SRC_URI="http://www.harbo.net/downloads/${P#cl-}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=defpatt

S=${WORKDIR}/${P#cl-}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc README ChangeLog
}
