# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-spatial-trees/cl-spatial-trees-0.2.ebuild,v 1.3 2007/08/11 17:06:59 beandog Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp library providing access to dynamic index structures for spatially-extended data."
HOMEPAGE="http://www.cliki.net/spatial-trees"
SRC_URI="http://ftp.linux.org.uk/pub/lisp/cclan/spatial-trees-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=spatial-trees

S=${WORKDIR}/spatial-trees-${PV}

src_install() {
	common-lisp-install *.{asd,lisp}
	common-lisp-system-symlink
	dodoc LICENCE TODO
}
