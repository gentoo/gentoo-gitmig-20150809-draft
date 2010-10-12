# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyregion/pyregion-1.0.ebuild,v 1.1 2010/10/12 23:12:36 bicatali Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python module to parse ds9 region file"
HOMEPAGE="http://leejjoon.github.com/pyregion/"
SRC_URI="http://github.com/downloads/leejjoon/${PN}/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}"

RESTRICT_PYTHON_ABIS="3.*"
