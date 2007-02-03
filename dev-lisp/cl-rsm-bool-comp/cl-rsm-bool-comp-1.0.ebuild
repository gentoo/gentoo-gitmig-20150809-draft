# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-bool-comp/cl-rsm-bool-comp-1.0.ebuild,v 1.6 2007/02/03 17:41:53 flameeyes Exp $

inherit common-lisp eutils

DESCRIPTION="McIntire's Common Lisp Boolean Function Comparison Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-bool-comp.html"
SRC_URI="mirror://gentoo/cl-rsm-bool-comp_1.0.tar.gz"

LICENSE="BSD"
SLOT="0"
# Compilation problems on SBCL and runtime SEGV on CMUCL
KEYWORDS="-x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp "

CLPACKAGE=rsm-bool-comp

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
