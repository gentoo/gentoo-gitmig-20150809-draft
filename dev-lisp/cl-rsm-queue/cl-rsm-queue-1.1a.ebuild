# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-queue/cl-rsm-queue-1.1a.ebuild,v 1.1 2004/02/12 09:13:20 mkennedy Exp $

inherit common-lisp

DESCRIPTION="R. Scott McIntire's Common Lisp queue library."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-queue.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-queue/cl-rsm-queue_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
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
