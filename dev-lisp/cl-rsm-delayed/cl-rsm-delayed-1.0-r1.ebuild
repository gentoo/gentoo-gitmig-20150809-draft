# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-delayed/cl-rsm-delayed-1.0-r1.ebuild,v 1.1 2004/02/12 09:13:19 mkennedy Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp Delayed Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-delayed.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-delayed/cl-rsm-delayed_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp dev-lisp/cl-rsm-queue dev-lisp/cl-rsm-filter"

CLPACKAGE=rsm-delayed

S=${WORKDIR}/${P}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
