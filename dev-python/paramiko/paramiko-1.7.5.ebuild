# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paramiko/paramiko-1.7.5.ebuild,v 1.2 2009/10/07 20:38:46 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="SSH2 implementation for Python"
HOMEPAGE="http://www.lag.net/paramiko/"
SRC_URI="http://www.lag.net/paramiko/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="doc examples"

RDEPEND=">=dev-python/pycrypto-1.9_alpha6"
DEPEND="${RDEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}"/${PN}-1.6.3-no-setuptools.patch
	epatch "${FILESDIR}"/${PN}-1.7.2-tests_cleanup.patch
}

src_test() {
	testing() {
		"$(PYTHON)" test.py --verbose
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	use doc && dohtml -r docs/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demos
	fi
}
