# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/brag/brag-1.2.9-r2.ebuild,v 1.8 2004/08/08 00:27:59 slarti Exp $

inherit eutils

IUSE=""

DESCRIPTION="Brag collects and assembles multipart binary attachments from newsgroups."
SRC_URI="mirror://sourceforge/brag/${P}.tar.gz"
HOMEPAGE="http://brag.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND="dev-lang/tcl
	net-news/yencode
	net-news/yydecode
	net-mail/metamail
	app-arch/sharutils"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-r1-gentoo.patch
}

src_compile() {
	true
}

src_install() {
	dobin brag
	dodoc CHANGES README
	doman brag.1
}
