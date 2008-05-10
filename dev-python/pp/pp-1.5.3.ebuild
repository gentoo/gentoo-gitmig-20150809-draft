# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pp/pp-1.5.3.ebuild,v 1.1 2008/05/10 10:14:54 hawking Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Parallel and distributed programming for Python"
HOMEPAGE="http://www.parallelpython.com/"
SRC_URI="http://www.parallelpython.com/downloads/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

src_install() {
	distutils_src_install

	doman ppserver.1
	use doc && dohtml ppdoc.html

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r "${S}/examples"
	fi
}
