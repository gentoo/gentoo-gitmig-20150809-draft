# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrypy/cherrypy-3.2.0_rc1.ebuild,v 1.1 2010/11/14 21:08:12 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PV="${PV/_/}"
MY_P="CherryPy-${MY_PV}"

DESCRIPTION="CherryPy is a pythonic, object-oriented HTTP framework"
HOMEPAGE="http://www.cherrypy.org/ http://pypi.python.org/pypi/CherryPy"
SRC_URI="http://download.cherrypy.org/${PN}/${MY_PV}/${MY_P}.tar.gz
	http://download.cherrypy.org/${PN}/${MY_PV}/${MY_P}-py3.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc"

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_unpack() {
	unpack ${MY_P}-py3.tar.gz
	mv "${S}" "${S}-py3"
	unpack ${MY_P}.tar.gz
}

src_prepare() {
	preparation() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			pushd "${S}-py3" > /dev/null
			sed -e "s/except cherrypy.InternalRedirect, ir:/except cherrypy.InternalRedirect as ir:/" -i cherrypy/_cpnative_server.py
			popd > /dev/null

			cp -pr "${S}-py3" "${S}-${PYTHON_ABI}" || return 1
		else
			cp -pr "${S}" "${S}-${PYTHON_ABI}" || return 1
		fi
	}
	python_execute_function preparation
}

src_test() {
	testing() {
		PYTHONPATH="build/lib" "$(PYTHON)" cherrypy/test/test.py --dumb
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r cherrypy/tutorial || die "Installation of documentation failed"
	fi

	delete_documentation_and_tests() {
		rm -fr "${ED}$(python_get_sitedir)/cherrypy/"{test,tutorial}
	}
	python_execute_function -q delete_documentation_and_tests
}
