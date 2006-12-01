# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chardet/chardet-1.0.ebuild,v 1.1 2006/12/01 02:15:59 beandog Exp $

inherit distutils

DESCRIPTION="Character encoding auto-detection in Python."
HOMEPAGE="http://chardet.feedparser.org/"
SRC_URI="http://chardet.feedparser.org/download/${P}.tgz"
IUSE=""
DEPEND=""
RDEPEND=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	distutils_src_install
	dohtml -r ${S}/docs/
}
