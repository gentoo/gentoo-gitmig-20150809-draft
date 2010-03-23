# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-4.8.4.ebuild,v 1.1 2010/03/23 18:37:57 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit db-use distutils eutils multilib

DESCRIPTION="Python bindings for Berkeley DB"
HOMEPAGE="http://www.jcea.es/programacion/pybsddb.htm http://pypi.python.org/pypi/bsddb3"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
# Documentation missing in >=4.8.2 tarball.
# IUSE="doc"

RDEPEND=">=sys-libs/db-4.6"
DEPEND="${RDEPEND}
	dev-python/setuptools"
#	doc? ( dev-python/sphinx )

DOCS="TODO.txt"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${PN}-4.8.3-BSDDB_TEST_PATH.patch"
}

src_compile() {
	local DB_VER
	if has_version sys-libs/db:4.8; then
		DB_VER="4.8"
	elif has_version sys-libs/db:4.7; then
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

#	if use doc; then
#		mkdir html
#		sphinx-build docs html || die "Generation of documentation failed"
#	fi
}

src_test() {
	tests() {
		rm -f build
		ln -s build-${PYTHON_ABI} build

		echo BSDDB_TEST_PATH="${T}/tests-${PYTHON_ABI}" "$(PYTHON)" test.py
		BSDDB_TEST_PATH="${T}/tests-${PYTHON_ABI}" "$(PYTHON)" test.py
	}
	python_execute_function tests
}

src_install() {
	distutils_src_install

	rm -fr "${D}"usr/lib*/python*/site-packages/${PN}/tests

#	use doc && dohtml -r html/*
}
