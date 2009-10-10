# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flup/flup-1.0.2.ebuild,v 1.3 2009/10/10 16:58:06 grobian Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"

DESCRIPTION="Random assortment of WSGI servers"
HOMEPAGE="http://www.saddi.com/software/flup/"
SRC_URI="http://www.saddi.com/software/${PN}/dist/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"
