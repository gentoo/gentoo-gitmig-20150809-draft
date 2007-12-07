# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/mattricks/mattricks-0.7.ebuild,v 1.5 2007/12/07 00:04:32 dirtyepic Exp $

inherit distutils eutils

MY_P=${P/m/M}
DESCRIPTION="Hattrick Manager"
HOMEPAGE="http://www.lysator.liu.se/mattricks/download.en.html"
SRC_URI="http://www.lysator.liu.se/mattricks/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="<dev-python/wxpython-2.8
		dev-python/pyxml"

S=${WORKDIR}/${MY_P}

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}"/${P}-wxversion.patch
}
