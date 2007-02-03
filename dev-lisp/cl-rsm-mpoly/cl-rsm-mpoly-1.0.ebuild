# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-mpoly/cl-rsm-mpoly-1.0.ebuild,v 1.5 2007/02/03 17:45:37 flameeyes Exp $

inherit common-lisp

DESCRIPTION="McIntire's Common Lisp Multivariate Polynomial Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-mpoly.html"
SRC_URI="mirror://gentoo/cl-rsm-mpoly_1.0.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp dev-lisp/cl-rsm-filter"

CLPACKAGE=rsm-mpoly

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
