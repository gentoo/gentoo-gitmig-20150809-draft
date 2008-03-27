# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-gen-prog/cl-rsm-gen-prog-1.0.ebuild,v 1.5 2008/03/27 16:34:59 armin76 Exp $

inherit common-lisp

DESCRIPTION="McIntire's Common Lisp Genetic Programming Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-gen-prog"
SRC_URI="mirror://gentoo/cl-rsm-gen-prog_1.0.tar.gz"
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

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
