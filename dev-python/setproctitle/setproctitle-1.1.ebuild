# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setproctitle/setproctitle-1.1.ebuild,v 1.1 2010/07/19 00:14:13 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Allow customization of the process title."
HOMEPAGE="http://code.google.com/p/py-setproctitle/ http://pypi.python.org/pypi/setproctitle"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="HISTORY README"

src_prepare() {
	python_copy_sources

	conversion() {
		[[ "${PYTHON_ABI}" == 2.* ]] && return
		2to3-${PYTHON_ABI} -w --no-diffs tests > /dev/null
	}
	python_execute_function \
		--action-message 'Applying patches for $(python_get_implementation) $(python_get_version)' \
		--failure-message 'Applying patches for $(python_get_implementation) $(python_get_version) failed' \
		-s conversion
}

src_test() {
	testing() {
		if [[ "${PYTHON_ABI}" == 2.* ]]; then
			echo PYTHONPATH="$(ls -d build/lib.*)" nosetests
			PYTHONPATH="$(ls -d build/lib.*)" nosetests || return 1
		else
			echo PYTHONPATH="$(ls -d build/lib.*)" "$(PYTHON)" tests/setproctitle_test.py
			PYTHONPATH="$(ls -d build/lib.*)" "$(PYTHON)" tests/setproctitle_test.py || return 1
		fi
	}
	python_execute_function -s testing
}
