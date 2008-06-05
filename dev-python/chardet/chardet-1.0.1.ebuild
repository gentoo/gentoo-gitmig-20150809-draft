# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chardet/chardet-1.0.1.ebuild,v 1.1 2008/06/05 20:50:07 dev-zero Exp $

inherit distutils

DESCRIPTION="Character encoding auto-detection in Python."
HOMEPAGE="http://chardet.feedparser.org/"
SRC_URI="http://chardet.feedparser.org/download/${P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	distutils_src_install
	dohtml -r "${S}/docs/*"
}
