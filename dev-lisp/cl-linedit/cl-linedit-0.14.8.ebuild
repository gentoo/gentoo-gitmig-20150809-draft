# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-linedit/cl-linedit-0.14.8.ebuild,v 1.1 2004/02/15 10:33:49 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Linedit is a readline-style library written in Common Lisp that provides customizable line-editing features."
HOMEPAGE=""
SRC_URI="http://common-lisp.net/project/linedit/files/linedit_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-terminfo
	dev-lisp/cl-uffi"

CLPACKAGE=linedit

S=${WORKDIR}/linedit_${PV}

src_unpack() {
	unpack ${A}
	# adds uffi-loader.lisp, removes building .so files
	epatch ${FILESDIR}/${PV}-linedit.asd-uffi-glue-gentoo.patch
	cp ${FILESDIR}/${PV}-Makefile ${S}/Makefile
}

src_compile() {
	make || die
}

src_install() {
	common-lisp-install *.lisp linedit.asd version.lisp-expr
	common-lisp-system-symlink
	dodoc LICENSE
	exeinto /usr/lib/linedit
	doexe *.so
}
