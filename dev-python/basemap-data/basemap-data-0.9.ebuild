# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/basemap-data/basemap-data-0.9.ebuild,v 1.1 2007/02/24 00:50:49 bicatali Exp $

NEED_PYTHON=2.2

inherit distutils

DESCRIPTION="Data for matplotlib basemap toolkit"
HOMEPAGE="http://matplotlib.sourceforge.net/matplotlib.toolkits.basemap.basemap.html"
SRC_URI="mirror://sourceforge/matplotlib/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
