# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/brag/brag-1.4.1.ebuild,v 1.4 2004/08/08 00:27:59 slarti Exp $

IUSE=""

DESCRIPTION="Brag collects and assembles multipart binary attachments from newsgroups."
SRC_URI="mirror://sourceforge/brag/${P}.tar.gz"
HOMEPAGE="http://brag.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

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
