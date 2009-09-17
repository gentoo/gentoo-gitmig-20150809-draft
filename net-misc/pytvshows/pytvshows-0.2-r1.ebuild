# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pytvshows/pytvshows-0.2-r1.ebuild,v 1.1 2009/09/17 05:01:19 darkside Exp $

inherit distutils eutils

DESCRIPTION="downloads torrents for TV shows from RSS feeds provided by ezrss.it."
HOMEPAGE="http://sourceforge.net/projects/pytvshows/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/feedparser"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}/${P}-ezrss.it.patch"
}
