# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/charm/charm-1.4.0.ebuild,v 1.1 2004/02/28 23:09:55 liquidx Exp $

inherit distutils

DESCRIPTION="A text based livejournal client"
HOMEPAGE="http://ljcharm.sourceforge.net/"
SRC_URI="mirror://sourceforge/ljcharm/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	mydoc="CHANGES.charm README.charm sample.charmrc"
	distutils_src_install
	dobin charm
}
