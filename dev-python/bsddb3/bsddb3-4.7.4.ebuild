# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-4.7.4.ebuild,v 1.1 2009/02/01 00:13:58 patrick Exp $

EAPI="1"

NEED_PYTHON=2.5

inherit distutils db-use multilib

DESCRIPTION="Python bindings for BerkeleyDB"
HOMEPAGE="http://www.jcea.es/programacion/pybsddb.htm"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=sys-libs/db-4.6"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

src_compile() {
	local DB_VER
	if has_version sys-libs/db:4.7; then
		DB_VER="4.7"
	else
		DB_VER="4.6"
	fi

	sed -i \
		-e "s/dblib = 'db'/dblib = '$(db_libname ${DB_VER})'/" \
		setup2.py setup3.py || die "sed failed"

	distutils_src_compile \
		"--berkeley-db=/usr" \
		"--berkeley-db-incdir=$(db_includedir ${DB_VER})" \
		"--berkeley-db-libdir=/usr/$(get_libdir)"

	if use doc ; then
		mkdir html
		sphinx-build docs html || die "building docs failed"
	fi
}

src_install() {
	DOCS="TODO.txt"
	distutils_src_install

	distutils_python_version
	rm -rf "${D}/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/tests"

	use doc && dohtml -r html/*
}

src_test() {
	distutils_python_version
	"${python}" test.py || die "tests failed"
}
