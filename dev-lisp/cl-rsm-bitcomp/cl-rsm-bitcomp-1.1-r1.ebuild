# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-bitcomp/cl-rsm-bitcomp-1.1-r1.ebuild,v 1.5 2007/02/03 17:41:33 flameeyes Exp $

inherit common-lisp eutils

DESCRIPTION="McIntire's Common Lisp Bit Compression Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-bitcomp.html"
SRC_URI="mirror://gentoo/cl-rsm-bitcomp_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/cl-rsm-queue
	dev-lisp/cl-plus"

CLPACKAGE=rsm-bitcomp

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-defconstant-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
