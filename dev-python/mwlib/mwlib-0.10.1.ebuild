# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mwlib/mwlib-0.10.1.ebuild,v 1.1 2009/04/18 20:15:42 patrick Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Tools for parsing Mediawiki content to other formats"
HOMEPAGE="http://code.pediapress.com/wiki/wiki"
SRC_URI="http://pypi.python.org/packages/source/m/mwlib/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="virtual/latex-base
	dev-lang/perl
	dev-python/imaging
	dev-python/lxml
	>=dev-python/simplejson-1.3
	>=dev-python/python-dateutil-1.4.1
	>=dev-python/flup-1.0
	=dev-python/odfpy-0.7*
	>=dev-python/pyparsing-1.4.11"

src_install() {
	distutils_src_install
}
