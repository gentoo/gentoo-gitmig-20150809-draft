# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rawdog/rawdog-2.11.ebuild,v 1.1 2008/05/13 18:52:04 hawking Exp $

NEED_PYTHON=2.2
inherit distutils eutils

DESCRIPTION="Rawdog - RSS Aggregator Without Delusions Of Grandeur"
HOMEPAGE="http://offog.org/code/rawdog.html"
SRC_URI="http://offog.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/feedparser"

DOCS="NEWS PLUGINS config style.css"
PYTHON_MODNAME="rawdoglib"

src_unpack() {
	distutils_src_unpack

	# Use system feedparser.
	epatch "${FILESDIR}"/${P}-system-feedparser.patch
	rm rawdoglib/feedparser.py || die "failed to remove feedparser.py"
}

