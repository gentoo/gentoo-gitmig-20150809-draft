# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-4.5.0.ebuild,v 1.4 2007/07/11 06:19:47 mr_bones_ Exp $

NEED_PYTHON=2.1

inherit distutils db-use multilib

DESCRIPTION="Python bindings for BerkeleyDB"
HOMEPAGE="http://pybsddb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pybsddb/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND=">=sys-libs/db-4.0"

src_compile() {
	sed -i \
		-e "s/dblib = 'db'/dblib = '$(db_libname)'/" \
		setup.py
	distutils_src_compile \
		"--berkeley-db=/usr" \
		"--berkeley-db-incdir=$(db_includedir)" \
		"--berkeley-db-libdir=/usr/$(get_libdir)"
}

src_install() {
	DOCS="TODO.txt"
	distutils_src_install
	use doc && dohtml -r docs/*
}

src_test() {
	"${python}" test.py || die "tests failed"
}
