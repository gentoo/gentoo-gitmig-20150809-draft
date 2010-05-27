# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/decorator/decorator-3.1.2.ebuild,v 1.8 2010/05/27 17:01:55 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Simplifies the usage of decorators for the average programmer"
HOMEPAGE="http://pypi.python.org/pypi/decorator"
SRC_URI="http://pypi.python.org/packages/source/d/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE="doc"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="decorator.py"

src_test() {
	# multiprocessing module is available only in Python >=2.6, and isn't used anyway.
	sed -i -e '/multiprocessing/d' documentation.py || die
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" documentation.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
	   dodoc documentation.pdf || die "dodoc pdf doc failed"
	   dohtml documentation.html || die "dohtml html doc failed"
	fi
}
