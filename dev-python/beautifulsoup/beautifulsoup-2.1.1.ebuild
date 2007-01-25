# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beautifulsoup/beautifulsoup-2.1.1.ebuild,v 1.4 2007/01/25 04:58:17 beandog Exp $

inherit distutils

MY_P=${P/beautifulsoup/BeautifulSoup}
S=${WORKDIR}/${MY_P}

DESCRIPTION="HTML/XML parser for quick-turnaround applications like screen-scraping."
HOMEPAGE="http://www.crummy.com/software/BeautifulSoup/"
SRC_URI="http://www.crummy.com/software/BeautifulSoup/download/2.x/${MY_P}.tar.gz"

LICENSE="PSF-2.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2"
RDEPEND="${DEPEND}"
