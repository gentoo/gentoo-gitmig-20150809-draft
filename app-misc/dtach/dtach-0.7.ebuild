# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dtach/dtach-0.7.ebuild,v 1.5 2005/07/16 19:47:27 swegener Exp $

DESCRIPTION="A program that emulates the detach feature of screen"
HOMEPAGE="http://dtach.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=""

src_install() {
	dobin dtach || die "dobin failed"
	doman dtach.1 || die "doman failed"
	dodoc README || die "dodoc failed"
}
