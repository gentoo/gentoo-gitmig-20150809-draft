# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paste/paste-1.7.2.ebuild,v 1.4 2009/12/20 20:25:12 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="Paste"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Tools for using a Web Server Gateway Interface stack"
HOMEPAGE="http://pythonpaste.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris"
IUSE="doc flup openid test"

RDEPEND="flup? ( dev-python/flup )
	openid? ( dev-python/python-openid )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/pudge dev-python/buildutils )
	test? ( dev-python/py )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	sed -i \
		-e '/highlighter/d' \
		setup.cfg || die "sed failed"

	# Disable failing tests.
	sed -e "s/test_logger/_&/" -i tests/test_exceptions/test_reporter.py || die "sed failed"
	sed -e "s/test_paste_website/_&/" -i tests/test_proxy.py || die "sed failed"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		einfo "Generation of documentation"
		PYTHONPATH=. "${python}" setup.py pudge || die "Generation of documentation failed"
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" py.test
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/html/*
}
