# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/charm/charm-1.7.0.ebuild,v 1.1 2007/03/16 12:47:41 lucass Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="A text based livejournal client"
HOMEPAGE="http://ljcharm.sourceforge.net/"
SRC_URI="mirror://sourceforge/ljcharm/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/1\.6\.0/1.7.0/' \
		-e 's/("share\/doc\/charm", .*),/\\/' \
		setup.py
}

src_install() {
	DOCS="CHANGES.charm sample.charmrc"
	distutils_src_install
	dohtml charm.html
}
