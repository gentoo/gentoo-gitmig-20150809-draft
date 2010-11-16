# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mako/mako-0.3.5.ebuild,v 1.3 2010/11/16 17:36:43 tomka Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="Mako-${PV}"

DESCRIPTION="A Python templating language"
HOMEPAGE="http://www.makotemplates.org/ http://pypi.python.org/pypi/Mako"
SRC_URI="http://www.makotemplates.org/downloads/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc test"

RDEPEND=">=dev-python/beaker-1.1
	>=dev-python/markupsafe-0.9.2"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/nose )"

S="${WORKDIR}/${MY_P}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_prepare() {
	distutils_src_prepare

	2to3_conversion() {
		[[ "${PYTHON_ABI}" == 2.* ]] && return
		2to3-${PYTHON_ABI} -n -w --no-diffs mako
	}
	python_execute_function -s 2to3_conversion
}

src_test() {
	testing() {
		[[ "${PYTHON_ABI}" == 3.* ]] && return
		PYTHONPATH="build/lib" nosetests
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml doc/*html doc/*css || die "dohtml failed"
	fi
}
