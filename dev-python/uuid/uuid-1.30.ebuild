# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/uuid/uuid-1.30.ebuild,v 1.4 2009/08/30 00:42:13 arfrever Exp $

EAPI="2"

NEED_PYTHON="2.3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="UUID object and generation functions"
HOMEPAGE="http://pypi.python.org/pypi/uuid"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"

RESTRICT_PYTHON_ABIS="3*"

pkg_postinst() {
	python_mod_optimize uuid.py
}

pkg_postrm() {
	python_mod_cleanup
}
