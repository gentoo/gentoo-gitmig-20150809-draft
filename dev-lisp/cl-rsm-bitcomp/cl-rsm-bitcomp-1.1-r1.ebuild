# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-bitcomp/cl-rsm-bitcomp-1.1-r1.ebuild,v 1.4 2005/02/10 09:18:30 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="McIntire's Common Lisp Bit Compression Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-bitcomp.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-bitcomp/cl-rsm-bitcomp_${PV}.tar.gz"
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
