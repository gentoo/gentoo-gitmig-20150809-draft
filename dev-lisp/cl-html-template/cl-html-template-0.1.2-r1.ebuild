# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-html-template/cl-html-template-0.1.2-r1.ebuild,v 1.1 2004/02/12 09:13:13 mkennedy Exp $

inherit common-lisp

DESCRIPTION="HTML-TEMPLATE is a portable templating library for Common Lisp"
HOMEPAGE="http://weitz.de/html-template/
	http://www.cliki.net/html-template"
SRC_URI="mirror://gentoo/${P/cl-/}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=html-template

S=${WORKDIR}/${P/cl-/}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc CHANGELOG INSTALLATION
	dohtml doc/*.html
}
