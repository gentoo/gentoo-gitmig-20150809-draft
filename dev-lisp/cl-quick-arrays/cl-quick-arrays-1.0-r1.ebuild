# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-quick-arrays/cl-quick-arrays-1.0-r1.ebuild,v 1.8 2007/02/03 17:40:54 flameeyes Exp $

inherit common-lisp

DEB_PV=8

DESCRIPTION="Common Lisp library offering less flexible, but faster arrays"
HOMEPAGE="http://packages.debian.org/unstable/libs/cl-quick-arrays.html
	http://www.cliki.net/quick-arrays"
SRC_URI="mirror://gentoo/${PN}_${PV}-${DEB_PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=quick-arrays

S=${WORKDIR}/quick-arrays-${PV}

src_compile() {
	:
}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	do-debian-credits
}
