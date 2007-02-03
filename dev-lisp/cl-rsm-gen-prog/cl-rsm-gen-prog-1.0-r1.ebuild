# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-gen-prog/cl-rsm-gen-prog-1.0-r1.ebuild,v 1.4 2007/02/03 17:44:15 flameeyes Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp Genetic Programming Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-gen-prog.html"
SRC_URI="mirror://gentoo/cl-rsm-gen-prog_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp dev-lisp/cl-rsm-filter dev-lisp/cl-rsm-cache dev-lisp/cl-rsm-random"

CLPACKAGE=rsm-gen-prog

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
