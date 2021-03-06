# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simpletal/simpletal-5.1-r1.ebuild,v 1.1 2015/01/09 10:29:37 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python3_3 )

inherit distutils-r1

MY_PN="SimpleTAL"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Stand alone Python implementation of the Zope TAL, TALES and METAL specs for HTML/XML templates"
HOMEPAGE="http://www.owlfish.com/software/simpleTAL/ http://pypi.python.org/pypi/SimpleTAL"
SRC_URI="http://www.owlfish.com/software/simpleTAL/downloads/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="5"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -e "s/^TEMP_DIR=.*/TEMP_DIR=os.curdir/" \
		-i tests/TALUtilsTests/TemplateCacheTestCases.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" runtests.py || die "tests failed"
}

python_install_all() {
	use doc && local HTML_DOCS=( documentation/html/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
