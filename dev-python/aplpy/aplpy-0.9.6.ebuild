# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/aplpy/aplpy-0.9.6.ebuild,v 1.1 2011/06/07 22:15:59 bicatali Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MYP="APLpy-${PV}"

DESCRIPTION="Astronomical Plotting Library in Python"
HOMEPAGE="http://aplpy.github.com/ http://pypi.python.org/pypi/APLpy"
SRC_URI="https://github.com/downloads/${PN}/${PN}/${MYP}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}
	dev-python/matplotlib
	dev-python/pyfits
	dev-python/pywcs"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MYP}"
