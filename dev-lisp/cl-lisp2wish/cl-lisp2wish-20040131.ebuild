# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-lisp2wish/cl-lisp2wish-20040131.ebuild,v 1.5 2005/04/11 20:15:10 mkennedy Exp $

inherit common-lisp eutils

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="lisp2wish is a simple interface to the Tk Graphics Toolkit."
HOMEPAGE="http://www.cliki.net/lisp2wish"
SRC_URI="http://www.riise-data.net/lisp2wish-${MY_PV}.tgz"
LICENSE="lisp2wish"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""
DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"
RDEPEND="${DEPEND}
	dev-lang/tk"

CLPACKAGE=lisp2wish

S=${WORKDIR}/lisp2wish

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-USER-package-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README*
}
