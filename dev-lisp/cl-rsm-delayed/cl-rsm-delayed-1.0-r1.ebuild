# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-delayed/cl-rsm-delayed-1.0-r1.ebuild,v 1.3 2004/07/14 16:02:35 agriffis Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp Delayed Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-delayed.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-delayed/cl-rsm-delayed_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp dev-lisp/cl-rsm-queue dev-lisp/cl-rsm-filter"

CLPACKAGE=rsm-delayed

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
