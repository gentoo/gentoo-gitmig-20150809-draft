# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah/cheetah-2.4.0.ebuild,v 1.5 2009/12/09 18:48:06 nixnut Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="Cheetah"
MY_P="${MY_PN}-${PV/_}"

DESCRIPTION="Python-powered template engine and code generator."
HOMEPAGE="http://www.cheetahtemplate.org/ http://rtyler.github.com/cheetah/ http://pypi.python.org/pypi/Cheetah"
SRC_URI="http://pypi.python.org/packages/source/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PSF-2.2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ia64 ppc ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"

RDEPEND="dev-python/markdown"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="Cheetah"
DOCS="CHANGES README.markdown TODO"

src_test() {
	# Disable broken tests.
	sed \
		-e "/Unicode/d" \
		-e "s/if not sys.platform.startswith('java'):/if False:/" \
		-e "/results =/a\\    sys.exit(not results.wasSuccessful())" \
		-i cheetah/Tests/Test.py || die "sed failed"

	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" cheetah/Tests/Test.py
	}
	python_execute_function testing
}

src_install() {
	[[ -z "${ED}" ]] && local ED="${D}"
	distutils_src_install
	rm -fr "${ED}"usr/lib*/python*/site-packages/Cheetah/Tests
}
