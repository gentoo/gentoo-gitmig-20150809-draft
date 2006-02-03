# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-lw-compat/cl-lw-compat-0.21.ebuild,v 1.1 2006/02/03 17:55:39 mkennedy Exp $

inherit common-lisp

DESCRIPTION="LispWorks compatibility library for the Closer to MOP project."
HOMEPAGE="http://common-lisp.net/project/closer/closer-mop.html"
SRC_URI="ftp://common-lisp.net/pub/project/closer/${P/cl-/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

CLPACKAGE=lw-compat

S=${WORKDIR}/lw-compat

src_install() {
	common-lisp-install *.{asd,lisp}
	common-lisp-system-symlink
}
