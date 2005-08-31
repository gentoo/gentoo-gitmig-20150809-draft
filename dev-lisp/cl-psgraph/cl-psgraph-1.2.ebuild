# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-psgraph/cl-psgraph-1.2.ebuild,v 1.2 2005/08/31 18:00:43 swegener Exp $

inherit common-lisp

DESCRIPTION="Common Lisp library for the generation of PostScript pictures of directed acyclic graphs"
HOMEPAGE="http://www.cliki.net/psgraph
	http://common-lisp.net/project/asdf-packaging/"
SRC_URI="mirror://gentoo/${P#cl-}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"
S=${WORKDIR}/${P#cl-}

CLPACKAGE=psgraph

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc psgraph.{doc,catalog}
}
