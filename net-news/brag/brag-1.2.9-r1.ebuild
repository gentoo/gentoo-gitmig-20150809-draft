# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/brag/brag-1.2.9-r1.ebuild,v 1.2 2003/02/11 21:21:12 rajiv Exp $

IUSE=""

DESCRIPTION="Brag collects and assembles multipart binary attachements from newsgroups."
SRC_URI="mirror://sourceforge/brag/${P}.tar.gz"
HOMEPAGE="http://brag.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND="dev-lang/tcl
	net-news/yencode
	net-mail/metamail
	sys-apps/sharutils"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch < ${FILESDIR}/${P}-${PR}-gentoo.patch
}	

src_install() {
	dobin brag
	dodoc brag.spec CHANGES LICENSE README
	doman brag.1
}
