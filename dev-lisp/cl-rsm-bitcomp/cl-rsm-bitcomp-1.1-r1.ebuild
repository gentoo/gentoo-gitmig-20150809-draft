# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-bitcomp/cl-rsm-bitcomp-1.1-r1.ebuild,v 1.2 2004/06/24 23:51:15 agriffis Exp $

inherit common-lisp

DESCRIPTION="McIntire's Common Lisp Bit Compression Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-bitcomp.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-bitcomp/cl-rsm-bitcomp_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp dev-lisp/cl-rsm-queue"

CLPACKAGE=rsm-bitcomp

S=${WORKDIR}/${P}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
