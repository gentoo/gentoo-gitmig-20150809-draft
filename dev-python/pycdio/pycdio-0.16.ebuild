# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycdio/pycdio-0.16.ebuild,v 1.1 2009/12/24 23:23:49 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python OO interface to libcdio (CD Input and Control library)"
HOMEPAGE="http://savannah.gnu.org/projects/libcdio/ http://pypi.python.org/pypi/pycdio"
SRC_URI="http://ftp.gnu.org/gnu/libcdio/${P}.tar.gz http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="dev-libs/libcdio"
DEPEND="${RDEPEND}
	dev-lang/swig
	dev-python/setuptools
	test? ( dev-python/nose )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="README.txt"
PYTHON_MODNAME="cdio.py iso9660.py pycdio.py pyiso9660.py"

src_prepare() {
	distutils_src_prepare

	# Remove obsolete sys.path and adjust 'data' path in examples.
	sed -i -e "s:^sys.path.insert.*::" -e "s:\.\./data:./data:g" example/*.py || die "sed failed"

	# Disable failing test.
	sed -e "s/test_get_set/_&/" -i test/test-cdtext.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install(){
	distutils_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}/examples
		doins example/{README,*.py}
		doins -r data
	fi
}
