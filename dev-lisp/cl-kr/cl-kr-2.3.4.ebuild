# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-kr/cl-kr-2.3.4.ebuild,v 1.1 2005/02/10 09:18:30 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="KR is a highly flexible and dynamic prototype-based object system for Common Lisp."
HOMEPAGE="http://www.cliki.net/KR"
SRC_URI="http://www.inf.tu-dresden.de/~s1054849/kr_${PV}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

CLPACKAGE=kr

S=${WORKDIR}/kr_${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc kr-manual.ps kr.changes
}
