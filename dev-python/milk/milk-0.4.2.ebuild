# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/milk/milk-0.4.2.ebuild,v 1.2 2012/06/07 06:11:10 mr_bones_ Exp $

EAPI=4

# python cruft
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Machine learning toolkit in Python"
HOMEPAGE="http://luispedro.org/software/milk"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="test"
RDEPEND="dev-python/numpy"
DEPEND="dev-python/setuptools
	test? ( dev-python/milksets sci-libs/scipy )"
