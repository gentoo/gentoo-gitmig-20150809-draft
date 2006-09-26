# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-trivial-gray-streams/cl-trivial-gray-streams-20060925.ebuild,v 1.1 2006/09/26 05:01:53 mkennedy Exp $

inherit common-lisp

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}
MY_PN=${PN/cl-/}
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="A thin compatibility layer between Gray Stream Common Lisp implementations"
HOMEPAGE="http://common-lisp.net/project/cl-plus-ssl/#trivial-gray-streams"
SRC_URI="mirror://gentoo/trivial-gray-streams-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND=""

CLPACKAGE=trivial-gray-streams

S=${WORKDIR}/trivial-gray-streams

src_unpack() {
	unpack ${A}
	rm ${S}/Makefile
}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc README COPYING
}
