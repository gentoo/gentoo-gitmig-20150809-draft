# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/feedparser/feedparser-3.3.ebuild,v 1.2 2006/05/09 23:59:05 wormo Exp $

inherit distutils

DESCRIPTION="Parse RSS and Atom feeds in Python"
HOMEPAGE="http://www.feedparser.org/"
SRC_URI="mirror://sourceforge/feedparser/${P}.zip"
LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="app-arch/unzip"
S=${WORKDIR}/${PN}

PYTHON_MODNAME="feedparser"
DOCS="README LICENSE"

