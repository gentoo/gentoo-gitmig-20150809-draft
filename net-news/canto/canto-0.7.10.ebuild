# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/canto/canto-0.7.10.ebuild,v 1.1 2010/08/11 14:06:59 hwoarang Exp $

EAPI="2"

PYTHON_DEPEND="2:2.5"

inherit distutils

DESCRIPTION="Ncurses RSS client"
HOMEPAGE="http://www.codezen.org/canto/"
SRC_URI="http://codezen.org/static/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses[unicode]
	dev-python/chardet"
RDEPEND="${DEPEND}"
