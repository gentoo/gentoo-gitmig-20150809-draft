# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ltk/cl-ltk-0.8.7.ebuild,v 1.2 2005/04/10 20:42:16 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="LTK is a Common Lisp binding for the Tk graphics toolkit which does not require any Tk knowledge for its usage."
HOMEPAGE="http://www.peter-herth.de/ltk/"
SRC_URI="http://www.peter-herth.de/ltk/${P#cl-}.tgz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

RDEPEND="${DEPEND}
	dev-lang/tk"

CLPACKAGE=ltk

S=${WORKDIR}/${PN#cl-}

src_install() {
	common-lisp-install *.lisp ltk.asd remote.tcl
	common-lisp-system-symlink
	dodoc *.{txt,pdf}
}
