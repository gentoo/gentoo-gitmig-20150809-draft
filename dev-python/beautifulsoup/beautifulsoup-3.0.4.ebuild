# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beautifulsoup/beautifulsoup-3.0.4.ebuild,v 1.3 2007/08/25 22:46:56 beandog Exp $

NEED_PYTHON=2.3

inherit distutils

MY_P=${P/beautifulsoup/BeautifulSoup}
S=${WORKDIR}/${MY_P}

DESCRIPTION="HTML/XML parser for quick-turnaround applications like screen-scraping."
HOMEPAGE="http://www.crummy.com/software/BeautifulSoup/"
SRC_URI="http://www.crummy.com/software/BeautifulSoup/download/${MY_P}.tar.gz"

LICENSE="PSF-2.3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

src_test() {
	"${python}" BeautifulSoupTests.py || die "tests failed"
}
