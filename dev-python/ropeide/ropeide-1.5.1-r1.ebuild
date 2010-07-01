# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ropeide/ropeide-1.5.1-r1.ebuild,v 1.3 2010/07/01 04:13:16 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

DESCRIPTION="Python refactoring IDE"
HOMEPAGE="http://rope.sourceforge.net/ropeide.html http://pypi.python.org/pypi/ropeide"
SRC_URI="mirror://sourceforge/rope/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-python/rope-0.8.4"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install

	if use doc; then
		dodoc docs/*.txt || die "dodoc failed"
	fi
}
