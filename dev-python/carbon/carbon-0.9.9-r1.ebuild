# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/carbon/carbon-0.9.9-r1.ebuild,v 1.1 2012/03/22 07:22:18 patrick Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit python
inherit distutils

DESCRIPTION="Backend data caching and persistence daemon for Graphite"
HOMEPAGE="http://graphite.wikidot.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/twisted
	dev-python/txAMQP"
