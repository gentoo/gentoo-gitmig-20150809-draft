# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-aspectl/cl-aspectl-0.6.4.ebuild,v 1.6 2006/03/19 22:40:24 halcy0n Exp $

inherit common-lisp

DESCRIPTION="AspectL is a library that provides aspect-oriented extensions for Common Lisp/CLOS."
HOMEPAGE="http://common-lisp.net/project/aspectl/"
SRC_URI="http://common-lisp.net/project/aspectl/downloads/aspectl-${PV}.zip"

LICENSE="CCPL-Attribution-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"
DEPEND="${RDEPEND}
	app-arch/unzip"

CLPACKAGE=aspectl

S=${WORKDIR}/aspectl-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dohtml *.html *.css
	docinto tests
	dodoc tests/*
}
