# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-filter/cl-rsm-filter-1.1_beta2-r1.ebuild,v 1.6 2008/03/27 16:31:35 armin76 Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp Filter Library."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-filter"
SRC_URI="mirror://gentoo/cl-rsm-filter_${PV/_beta/b}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp dev-lisp/cl-rsm-queue"

CLPACKAGE=rsm-filter

S=${WORKDIR}/${P/_beta/b}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
