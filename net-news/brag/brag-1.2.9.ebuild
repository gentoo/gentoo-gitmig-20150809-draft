# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/brag/brag-1.2.9.ebuild,v 1.3 2003/07/13 16:53:07 aliz Exp $

IUSE=""

DESCRIPTION="Brag collects and assembles multipart binary attachements from newsgroups."
SRC_URI="mirror://sourceforge/brag/${P}.tar.gz"
HOMEPAGE="http://brag.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="dev-lang/tcl
	net-news/yencode
	net-mail/metamail
	sys-apps/sharutils"

src_install() {
	dobin brag
	dodoc brag.spec CHANGES LICENSE README
	doman brag.1
}
