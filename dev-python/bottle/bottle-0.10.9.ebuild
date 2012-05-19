# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bottle/bottle-0.10.9.ebuild,v 1.1 2012/05/19 10:53:54 xarthisius Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils eutils

DESCRIPTION="A fast and simple micro-framework for small web-applications"
HOMEPAGE="http://pypi.python.org/pypi/bottle http://bottlepy.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PYTHON_MODNAME=bottle.py

RDEPEND="dev-python/simplejson"
DEPEND="${RDEPEND} dev-python/setuptools"

src_prepare() {
	distutils_src_prepare

	sed -e "/^sys.path.insert/d" -i test/{servertest.py,testall.py} || die

	2to3_tests() {
		local p_maj=$(python_get_version -l --major)

		if [[ ! -d test-${p_maj} ]]; then
			cp -r test test-${p_maj}
			if [[ $p_maj == 3 ]]; then
				2to3-${PYTHON_ABI} -nw --no-diffs test-${p_maj}
			fi
		fi
	}
	python_execute_function 2to3_tests
}

src_test() {
	testing() {
		local p_maj=$(python_get_version -l --major)
		PYTHONPATH="build-${PYTHON_ABI}/lib/" "$(PYTHON)" test-${p_maj}/testall.py
	}
	python_execute_function  testing
}
