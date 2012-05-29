# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyacoustid/pyacoustid-0.7.ebuild,v 1.2 2012/05/29 17:13:25 jdhore Exp $

EAPI=4
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python module for Chromaprint acoustic fingerprinting and the Acoustid API"
HOMEPAGE="http://pypi.python.org/pypi/pyacoustid"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/chromaprint
		dev-python/audioread"
RDEPEND="${DEPEND}"
