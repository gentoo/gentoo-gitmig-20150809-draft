# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-queue/cl-rsm-queue-1.1a.ebuild,v 1.3 2004/06/24 23:53:28 agriffis Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp queue library."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-queue.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-queue/cl-rsm-queue_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp "

CLPACKAGE=rsm-queue

S=${WORKDIR}/${P}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
