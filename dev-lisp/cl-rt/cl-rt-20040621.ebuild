# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rt/cl-rt-20040621.ebuild,v 1.5 2007/02/03 17:48:12 flameeyes Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp regression tester from MIT"
HOMEPAGE="http://www-2.cs.cmu.edu/afs/cs/project/ai-repository/ai/lang/lisp/code/testing/rt/ http://packages.debian.org/unstable/devel/cl-rt.html http://www.cliki.net/rt"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/cl-rt_${PV}-${DEB_PV}.diff.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=rt

src_unpack() {
	unpack ${A}
	epatch cl-rt_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install rt.lisp ${FILESDIR}/rt.asd
	common-lisp-system-symlink
	dodoc rt-doc.txt rt-test.lisp
	do-debian-credits
}
