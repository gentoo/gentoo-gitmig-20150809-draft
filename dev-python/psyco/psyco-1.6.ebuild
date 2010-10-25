# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psyco/psyco-1.6.ebuild,v 1.3 2010/10/25 11:34:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2::2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7 3.*"

inherit distutils

DESCRIPTION="Python extension module which can massively speed up the execution of any Python code."
HOMEPAGE="http://psyco.sourceforge.net/"
SRC_URI="mirror://sourceforge/psyco/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~x86-linux"
IUSE="examples"

DEPEND=""
RDEPEND=""

src_prepare() {
	distutils_src_prepare

	# whrandom is deprecated in python-2.4
	# and removed in 2.5
	sed -i \
		-e "s/whrandom/random/g" \
		test/life.py test/life-psyco.py || die "sed failed"
}

src_test() {
	cd test

	testing() {
		PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" test_base.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins test/bpnn.py test/life.py test/life-psyco.py test/pystone.py || die "doins failed"
	fi
}
