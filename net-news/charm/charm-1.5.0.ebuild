# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/charm/charm-1.5.0.ebuild,v 1.2 2006/02/01 01:46:37 chutzpah Exp $

inherit distutils

DESCRIPTION="A text based livejournal client"
HOMEPAGE="http://ljcharm.sourceforge.net/"
SRC_URI="mirror://sourceforge/ljcharm/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

src_install() {
	mydoc="CHANGES.charm README.charm sample.charmrc"
	distutils_src_install
	dobin charm
}
