# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-random/cl-rsm-random-1.1.ebuild,v 1.3 2004/07/14 16:07:13 agriffis Exp $

inherit common-lisp

DESCRIPTION="McIntire's Common Lisp Random Number Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-random.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-random/cl-rsm-random_1.1.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-uffi"

CLPACKAGE=rsm-random

src_compile() {
	make linux || die
}

src_install() {
	exeinto /usr/lib/rsm-random
	doexe random.so
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
