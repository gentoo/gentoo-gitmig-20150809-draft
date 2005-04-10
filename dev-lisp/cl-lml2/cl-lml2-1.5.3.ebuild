# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-lml2/cl-lml2-1.5.3.ebuild,v 1.1 2005/04/10 20:40:11 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="A Common Lisp package for generating HTML and XHTML documents"
HOMEPAGE="http://www.b9.com/"
SRC_URI="ftp://ftp.b9.com/lml2/lml2-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=lml2

S=${WORKDIR}/lml2-${PV}

src_unpack() {
	unpack ${A}
}

src_install() {
	common-lisp-install *.lisp lml2.asd
	common-lisp-system-symlink
	dodoc README ChangeLog
	dohtml doc/readme.html
	docinto examples
	dodoc doc/make.lisp doc/Makefile doc/readme.lml
}
