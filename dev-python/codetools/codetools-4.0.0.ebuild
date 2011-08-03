# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/codetools/codetools-4.0.0.ebuild,v 1.1 2011/08/03 23:51:50 bicatali Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx

DESCRIPTION="Enthought Tool Suite: Code analysis and execution tools"
HOMEPAGE="http://code.enthought.com/projects/code_tools/ http://pypi.python.org/pypi/codetools"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

IUSE="doc examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/numpy
	>=dev-python/scimath-4.0
	>=dev-python/traits-4.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"


src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	VIRTUALX_COMMAND="distutils_src_test" virtualmake
}

src_install() {
	find -name "*LICENSE*.txt" -delete
	distutils_src_install

	if use doc; then
		pushd docs/build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _images _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi
}
