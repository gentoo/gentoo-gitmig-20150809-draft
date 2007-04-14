# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/packETH/packETH-1.4.ebuild,v 1.1 2007/04/14 19:27:11 vanquirius Exp $

inherit eutils

DESCRIPTION="Packet generator tool for ethernet"
HOMEPAGE="http://packeth.sourceforge.net/"
SRC_URI="mirror://sourceforge/packeth/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
		insinto /usr/bin
		dobin packETH || die
		insinto /usr/share/pixmaps/packETH
		doins pixmaps/*
}
