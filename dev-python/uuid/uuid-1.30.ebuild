# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/uuid/uuid-1.30.ebuild,v 1.1 2009/04/19 12:28:43 caleb Exp $

inherit distutils

DESCRIPTION="UUID object and generation functions"
HOMEPAGE="http://pypi.python.org/pypi/${PN}/${PV}"
SRC_URI="http://pypi.python.org/packages/source/u/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.3"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_install() {
	distutils_src_install
}

