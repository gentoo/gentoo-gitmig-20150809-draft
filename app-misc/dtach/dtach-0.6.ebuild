# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dtach/dtach-0.6.ebuild,v 1.2 2004/06/23 20:53:23 dholm Exp $

DESCRIPTION="A program that emulates the detach feature of screen"
HOMEPAGE="http://dtach.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""

src_install() {
	dobin dtach
	doman dtach.1
	dodoc README
}
