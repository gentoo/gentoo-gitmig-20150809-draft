# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tagpy/tagpy-0.90.1.ebuild,v 1.5 2006/06/27 15:51:44 sbriesen Exp $

inherit distutils

DESCRIPTION="Python bindings for media-libs/taglib"
HOMEPAGE="http://news.tiker.net/software/tagpy"
SRC_URI="http://news.tiker.net/news.tiker.net/download/software/tagpy/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND="virtual/python
	>=media-libs/taglib-1.4
	>=dev-libs/boost-1.33.0"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins test/*
}
