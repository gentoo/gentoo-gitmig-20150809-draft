# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/openc6/openc6-0.9.6_beta.ebuild,v 1.1 2004/07/13 17:01:54 rizzo Exp $

inherit kde eutils
need-qt 3.1

DESCRIPTION="An open source C6 client"
HOMEPAGE="http://openc6.sourceforge.net/"
SRC_URI="mirror://sourceforge/openc6/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="kde"

src_unpack() {
	unpack ${A}
	cd ${S}/c6
	epatch ${FILESDIR}/${P}-fixes.patch
}
src_compile() {
	econf `use_with kde` || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
}
