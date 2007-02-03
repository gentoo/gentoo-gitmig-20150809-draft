# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-finance/cl-rsm-finance-1.1-r1.ebuild,v 1.5 2007/02/03 17:43:16 flameeyes Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp Finance Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-finance.html"
SRC_URI="mirror://gentoo/cl-rsm-finance_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp "

CLPACKAGE=rsm-finance

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
