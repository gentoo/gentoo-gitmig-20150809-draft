# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/charm/charm-1.4.0.ebuild,v 1.3 2007/07/05 07:11:22 lucass Exp $

inherit distutils

DESCRIPTION="A text based livejournal client"
HOMEPAGE="http://ljcharm.sourceforge.net/"
SRC_URI="mirror://sourceforge/ljcharm/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

src_install() {
	DOCS="CHANGES.charm README.charm sample.charmrc"
	distutils_src_install
	dobin charm
}
