# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-colorize/cl-colorize-1.0.ebuild,v 1.3 2005/07/20 11:05:12 dholm Exp $

inherit common-lisp eutils

DESCRIPTION="Colorize is a Common Lisp application for colorizing Common Lisp, Scheme, Elisp, C, C++ or Java code."
HOMEPAGE="http://www.cliki.net/colorize"
SRC_URI="http://www.unmutual.info/software/colorize-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-html-encode
	dev-lisp/cl-split-sequence
	=dev-lisp/hyperspec-7.0"

S=${WORKDIR}/colorize-${PV}

CLPACKAGE=colorize

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-hyperspec-pathname-gentoo.patch || die
}

src_install() {
	common-lisp-install *.{lisp,asd} *-expr Mop_Sym.txt
	common-lisp-system-symlink
}
