# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-modal/cl-rsm-modal-1.0.ebuild,v 1.1 2003/10/18 10:13:19 mkennedy Exp $

inherit common-lisp

DESCRIPTION="McIntire's Common Lisp Modal Logic Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-modal.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-modal/cl-rsm-modal_1.0.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp "

CLPACKAGE=rsm-modal

S=${WORKDIR}/${P}

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
