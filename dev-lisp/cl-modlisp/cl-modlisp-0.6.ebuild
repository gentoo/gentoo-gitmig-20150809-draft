# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-modlisp/cl-modlisp-0.6.ebuild,v 1.1 2004/10/18 15:25:02 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp interface to the Marc Battyani's mod_lisp apache module."
HOMEPAGE="http://cl-modlisp.b9.com/"
SRC_URI="http://files.b9.com/cl-modlisp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-kmrcl"
RDEPEND="${DEPEND}
	www-apache/mod_lisp"

CLPACKAGE=modlisp

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc ChangeLog LICENSE
	dohtml doc/readme.html
}
