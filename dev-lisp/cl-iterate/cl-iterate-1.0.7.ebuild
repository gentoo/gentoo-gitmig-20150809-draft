# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-iterate/cl-iterate-1.0.7.ebuild,v 1.1 2004/08/04 21:04:41 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="ITERATE is a lispy and extensible replacement for the Common Lisp LOOP macro"
HOMEPAGE="http://www.cliki.net/iterate
	http://boinkor.net/lisp/iterate/"
SRC_URI="http://boinkor.net/lisp/iterate/iterate-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

S=${WORKDIR}/iterate-${PV}

CLPACKAGE=iterate

src_install() {
	common-lisp-install *.lisp iterate.asd
	common-lisp-system-symlink
	do-debian-credits
	dodoc doc/*.ps README ChangeLog
}
