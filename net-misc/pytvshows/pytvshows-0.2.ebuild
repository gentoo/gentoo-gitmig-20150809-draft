# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pytvshows/pytvshows-0.2.ebuild,v 1.3 2009/01/19 02:36:54 darkside Exp $

inherit distutils

DESCRIPTION="downloads torrents for TV shows from RSS feeds provided by tvRSS.net."
HOMEPAGE="http://sourceforge.net/projects/pytvshows/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/feedparser"
