# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simpletal/simpletal-4.1.ebuild,v 1.2 2009/07/21 20:51:29 arfrever Exp $

EAPI="2"

NEED_PYTHON=2.3

inherit distutils

MY_P=SimpleTAL-${PV}

DESCRIPTION="SimpleTAL is a stand alone Python implementation of the TAL, TALES and METAL specifications used in Zope to power HTML and XML templates."
SRC_URI="http://www.owlfish.com/software/simpleTAL/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://www.owlfish.com/software/simpleTAL/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="examples"
RESTRICT="test"

DEPEND="dev-python/pyxml"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	dohtml documentation/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	sed -i \
		-e 's/TEMP_DIR=.*/TEMP_DIR=os.curdir/' \
		tests/TALUtilsTests/TemplateCacheTestCases.py \
		|| die "sed failed"

	"${python}" runtests.py || die "tests failed"
}
