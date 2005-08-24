# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/mattricks/mattricks-0.7.ebuild,v 1.2 2005/08/24 04:25:24 mr_bones_ Exp $

inherit distutils

MY_P=${P/m/M}
DESCRIPTION="Hattrick Manager"
HOMEPAGE="http://www.lysator.liu.se/mattricks/download.en.html"
SRC_URI="http://www.lysator.liu.se/mattricks/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="<dev-python/wxpython-2.5
		dev-python/pyxml"

S=${WORKDIR}/${MY_P}
