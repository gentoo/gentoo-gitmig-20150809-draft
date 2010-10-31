# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mygpoclient/mygpoclient-1.5.ebuild,v 1.2 2010/10/31 17:35:38 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A gpodder.net client library"
HOMEPAGE="http://thp.io/2010/mygpoclient/"
SRC_URI="http://thp.io/2010/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-python/coverage
		dev-python/minimock
		dev-python/nose )"
