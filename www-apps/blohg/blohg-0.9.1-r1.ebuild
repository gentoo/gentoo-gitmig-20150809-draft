# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/blohg/blohg-0.9.1-r1.ebuild,v 1.1 2012/01/08 13:50:14 rafaelmartins Exp $

EAPI="3"

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

DESCRIPTION="A Mercurial-based blogging engine."
HOMEPAGE="http://blohg.org/ http://pypi.python.org/pypi/blohg"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc test"

DEPEND=">=dev-python/docutils-0.7
	>=dev-python/flask-0.7
	>=dev-python/flask-babel-0.6
	>=dev-python/flask-script-0.3
	>=dev-python/frozen-flask-0.7
	>=dev-python/jinja-2.5.2
	>=dev-vcs/mercurial-1.6
	dev-python/pyyaml
	dev-python/setuptools
	dev-python/pygments
	doc? ( dev-python/sphinx )"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix_tests.patch"
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo 'building documentation'
		emake -C docs html
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		einfo 'installing documentation'
		dohtml -r docs/_build/html/*
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo "If you're upgrading from <=blohg-0.5.1, please read the upgrade notes:"
	einfo "http://docs.blohg.org/upgrade/#from-0-5-1-to-0-6"
}
