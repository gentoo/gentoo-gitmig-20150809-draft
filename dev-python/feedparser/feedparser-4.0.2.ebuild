# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/feedparser/feedparser-4.0.2.ebuild,v 1.1 2006/01/05 14:56:28 liquidx Exp $

inherit distutils

DESCRIPTION="Parse RSS and Atom feeds in Python"
HOMEPAGE="http://www.feedparser.org/"
SRC_URI="mirror://sourceforge/feedparser/${P}.zip"
LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="app-arch/unzip"
S=${WORKDIR}

PYTHON_MODNAME="feedparser"
DOCS="README LICENSE"

src_install() {
	distutils_src_install
	dohtml docs/*
}
