# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pp/pp-1.5.7.ebuild,v 1.2 2009/08/17 04:37:31 arfrever Exp $

EAPI="2"

NEED_PYTHON="2.3"
SUPPORT_PYTHON_ABIS="1"

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

RESTRICT_PYTHON_ABIS="3*"

src_install() {
	distutils_src_install

	doman doc/ppserver.1
	use doc && dohtml doc/ppdoc.html

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r "${S}/examples"
	fi
}

pkg_postinst() {
	python_mod_optimize pp.py ppauto.py pptransport.py ppworker.py
}

pkg_postrm() {
	python_mod_cleanup
}
