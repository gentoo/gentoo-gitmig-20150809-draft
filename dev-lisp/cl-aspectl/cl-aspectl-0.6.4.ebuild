# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-aspectl/cl-aspectl-0.6.4.ebuild,v 1.2 2005/03/18 07:34:54 mkennedy Exp $

inherit common-lisp

DESCRIPTION="AspectL is a library that provides aspect-oriented extensions for Common Lisp/CLOS."
HOMEPAGE="http://common-lisp.net/project/aspectl/"
SRC_URI="http://common-lisp.net/project/aspectl/downloads/aspectl-${PV}.zip"

LICENSE="CCPL-Attribution-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=aspectl

S=${WORKDIR}/aspectl-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dohtml *.html *.css
	docinto tests
	dodoc tests/*
}
