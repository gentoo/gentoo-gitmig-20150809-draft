# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flup/flup-1.0.2.ebuild,v 1.9 2010/04/15 10:04:27 the_paya Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Random assortment of WSGI servers"
HOMEPAGE="http://trac.saddi.com/flup http://pypi.python.org/pypi/flup"
SRC_URI="http://www.saddi.com/software/${PN}/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"
