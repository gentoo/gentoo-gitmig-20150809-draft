# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hcluster/hcluster-0.2.0.ebuild,v 1.2 2010/07/22 16:32:46 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python hierarchical clustering package for Scipy"
HOMEPAGE="http://code.google.com/p/scipy-cluster/ http://pypi.python.org/pypi/hcluster"
SRC_URI="http://scipy-cluster.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/matplotlib
	dev-python/numpy"
RDEPEND="${DEPEND}"

# Tests need X display with matplotlib.
RESTRICT="test"
