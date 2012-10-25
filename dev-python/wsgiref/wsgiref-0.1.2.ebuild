# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wsgiref/wsgiref-0.1.2.ebuild,v 1.4 2012/10/25 05:12:06 patrick Exp $

EAPI=3

PYTHON_DEPEND=2
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Standalone release of the wsgiref library for WSGI 1.0.1 (PEP 3333)"
HOMEPAGE="http://pypi.python.org/pypi/wsgiref/0.1.2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="PSF-2 ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools
	app-arch/unzip"
RDEPEND="${DEPEND}"
