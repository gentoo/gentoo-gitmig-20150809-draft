# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/charm/charm-1.4.0.ebuild,v 1.1 2009/05/24 03:57:37 neurogeek Exp $

inherit distutils

DESCRIPTION="A text based livejournal client"
HOMEPAGE="http://ljcharm.sourceforge.net/"
SRC_URI="mirror://sourceforge/ljcharm/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

src_install() {
	DOCS="CHANGES.charm README.charm sample.charmrc"
	distutils_src_install
	dobin charm
}
