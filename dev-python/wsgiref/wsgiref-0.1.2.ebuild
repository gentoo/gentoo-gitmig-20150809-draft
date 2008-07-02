# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wsgiref/wsgiref-0.1.2.ebuild,v 1.2 2008/07/02 13:19:50 mr_bones_ Exp $

inherit distutils

DESCRIPTION="WSGI (PEP 333) Reference Library"
HOMEPAGE="http://cheeseshop.python.org/pypi/wsgiref"
SRC_URI="http://pypi.python.org/packages/source/w/${PN}/${P}.zip"
LICENSE="|| ( PSF-2.4 ZPL )"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
DEPEND="app-arch/unzip
	dev-python/setuptools"
RDEPEND="!>=dev-lang/python-2.5"
