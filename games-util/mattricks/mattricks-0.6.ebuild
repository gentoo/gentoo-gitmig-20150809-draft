# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/mattricks/mattricks-0.6.ebuild,v 1.1 2004/09/01 14:05:31 wolf31o2 Exp $

MY_P=${P/m/M}
DESCRIPTION="Hattrick Manager"
HOMEPAGE="http://www.lysator.liu.se/mattricks/download.en.html"
SRC_URI="http://www.lysator.liu.se/mattricks/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-python/wxpython
		dev-python/pyxml"


src_install() {
	python setup.py install --root=${D} --prefix=/usr || die
}

