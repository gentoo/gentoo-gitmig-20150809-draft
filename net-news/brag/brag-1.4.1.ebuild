# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/brag/brag-1.4.1.ebuild,v 1.5 2004/09/11 15:19:24 aliz Exp $

IUSE=""

DESCRIPTION="Brag collects and assembles multipart binary attachments from newsgroups."
SRC_URI="mirror://sourceforge/brag/${P}.tar.gz"
HOMEPAGE="http://brag.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~amd64"

RDEPEND="dev-lang/tcl
	app-text/uudeview"

src_compile() {
	true
}

src_install() {
	dobin brag
	dodoc CHANGES README
	doman brag.1
}
