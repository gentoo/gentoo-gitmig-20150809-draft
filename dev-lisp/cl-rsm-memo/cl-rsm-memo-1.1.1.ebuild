# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-memo/cl-rsm-memo-1.1.1.ebuild,v 1.4 2005/05/24 18:48:35 mkennedy Exp $

inherit common-lisp

DESCRIPTION="McIntire's Common Lisp Memoization Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-memo.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-memo/cl-rsm-memo_1.1.1.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp "

CLPACKAGE=rsm-memo

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
