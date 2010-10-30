# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-5.0.0.ebuild,v 1.6 2010/10/30 19:26:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2 3:3.1"
SUPPORT_PYTHON_ABIS="1"

inherit db-use distutils eutils multilib

DESCRIPTION="Python bindings for Berkeley DB"
HOMEPAGE="http://www.jcea.es/programacion/pybsddb.htm http://pypi.python.org/pypi/bsddb3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc sparc x86"
IUSE=""
# Documentation missing in >=4.8.2 tarball.
# IUSE="doc"

RDEPEND=">=sys-libs/db-4.6"
DEPEND="${RDEPEND}
	dev-python/setuptools"
#	doc? ( dev-python/sphinx )
RESTRICT_PYTHON_ABIS="3.0"

DOCS="TODO.txt"

src_compile() {
	local DB_VER
	if has_version sys-libs/db:5.0; then
		DB_VER="5.0"
	elif has_version sys-libs/db:4.8; then
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
		"--berkeley-db=${EPREFIX}/usr" \
		"--berkeley-db-incdir=${EPREFIX}$(db_includedir ${DB_VER})" \
		"--berkeley-db-libdir=${EPREFIX}/usr/$(get_libdir)"

#	if use doc; then
#		mkdir html
#		sphinx-build docs html || die "Generation of documentation failed"
#	fi
}

src_test() {
	tests() {
		rm -f build
		ln -s build-${PYTHON_ABI} build

		echo TMPDIR="${T}/tests-${PYTHON_ABI}" "$(PYTHON)" test.py
		TMPDIR="${T}/tests-${PYTHON_ABI}" "$(PYTHON)" test.py
	}
	python_execute_function tests
}

src_install() {
	distutils_src_install

	rm -fr "${ED}"usr/lib*/python*/site-packages/${PN}/tests

#	use doc && dohtml -r html/*
}
