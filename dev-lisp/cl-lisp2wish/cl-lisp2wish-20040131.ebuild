# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-lisp2wish/cl-lisp2wish-20040131.ebuild,v 1.3 2004/07/14 15:54:50 agriffis Exp $

inherit common-lisp

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="lisp2wish is a simple interface to the Tk Graphics Toolkit."
HOMEPAGE="http://www.cliki.net/lisp2wish"
SRC_URI="http://www.riise-data.net/lisp2wish-${MY_PV}.tgz"
LICENSE="lisp2wish"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"
RDEPEND="${DEPEND}
	dev-lang/tk"

CLPACKAGE=lisp2wish

S=${WORKDIR}/lisp2wish

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README*
}
