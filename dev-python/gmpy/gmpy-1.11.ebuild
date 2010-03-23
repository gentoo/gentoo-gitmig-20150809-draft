# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gmpy/gmpy-1.11.ebuild,v 1.2 2010/03/23 13:56:56 fauli Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python bindings for dev-libs/gmp"
HOMEPAGE="http://www.aleax.it/gmpy.html http://code.google.com/p/gmpy/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 x86"
IUSE=""

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	# HACK: distutils only support 'setup.py', so
	# we symlink what we need to 'setup.py' later
	mv setup.py setmp.py
}

src_compile() {
	local i
	for i in mp es; do
		ln -snf "set${i}.py" "setup.py" && distutils_src_compile
	done
}

src_test() {
	testing() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			pushd test3 > /dev/null
		else
			pushd test > /dev/null
		fi
		PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" gmpy_test.py || return 1
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	local i
	for i in mp es; do
		ln -snf "set${i}.py" "setup.py" && distutils_src_install
	done
	dohtml doc/index.html
	dodoc doc/gmpydoc.txt
}
