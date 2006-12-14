# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-html-template/cl-html-template-0.8.0.ebuild,v 1.1 2006/12/14 02:13:25 mkennedy Exp $

inherit common-lisp

DESCRIPTION="HTML-TEMPLATE is a portable templating library for Common Lisp"
HOMEPAGE="http://weitz.de/html-template/
	http://www.cliki.net/html-template"
SRC_URI="mirror://gentoo/${PN/cl-/}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
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
