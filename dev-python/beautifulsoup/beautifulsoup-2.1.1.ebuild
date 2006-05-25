# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beautifulsoup/beautifulsoup-2.1.1.ebuild,v 1.1 2006/05/25 16:10:33 marienz Exp $

inherit distutils

MY_P=${P/beautifulsoup/BeautifulSoup}
S=${WORKDIR}/${MY_P}

DESCRIPTION="HTML/XML parser for quick-turnaround applications like screen-scraping."
HOMEPAGE="http://www.crummy.com/software/BeautifulSoup/"
SRC_URI="http://www.crummy.com/software/BeautifulSoup/download/${MY_P}.tar.gz"

LICENSE="PSF-2.3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/python-2.2"
