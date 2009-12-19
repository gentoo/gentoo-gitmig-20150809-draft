# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paramiko/paramiko-1.7.6.ebuild,v 1.5 2009/12/19 17:04:46 jer Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="SSH2 protocol library"
HOMEPAGE="http://www.lag.net/paramiko/ http://pypi.python.org/pypi/paramiko"
SRC_URI="http://www.lag.net/paramiko/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris"
IUSE="doc examples"

RDEPEND=">=dev-python/pycrypto-1.9_alpha6"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	testing() {
		"$(PYTHON)" test.py --verbose
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/* || die "dohtml failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demos || die "doins failed"
	fi
}
