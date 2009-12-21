# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mwlib/mwlib-0.12.12.ebuild,v 1.1 2009/12/21 02:42:21 arfrever Exp $

EAPI="2"
NEED_PYTHON="2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Tools for parsing Mediawiki content to other formats"
HOMEPAGE="http://code.pediapress.com/wiki/wiki http://pypi.python.org/pypi/mwlib"
SRC_URI="http://pypi.python.org/packages/source/m/mwlib/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-python/flup-1.0
	dev-python/imaging
	>=dev-python/lockfile-0.8
	dev-python/lxml
	=dev-python/odfpy-0.9*
	>=dev-python/pyPdf-1.12
	>=dev-python/pyparsing-1.4.11
	>=dev-python/timelib-0.2
	>=dev-python/twisted-8.2.0
	>=dev-python/webob-0.9
	virtual/latex-base
	|| ( >=dev-lang/python-2.6 >=dev-python/simplejson-1.3 )"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="2.4 3.*"
