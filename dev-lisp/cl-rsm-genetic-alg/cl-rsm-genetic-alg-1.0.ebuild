# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-genetic-alg/cl-rsm-genetic-alg-1.0.ebuild,v 1.4 2004/07/14 16:04:12 agriffis Exp $

inherit common-lisp

DESCRIPTION="McIntire's Common Lisp Genetic Algorithm Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-genetic-alg.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-genetic-alg/cl-rsm-genetic-alg_1.0.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp dev-lisp/cl-rsm-cache"

CLPACKAGE=rsm-genetic-alg

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
