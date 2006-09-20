# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.14.0.ebuild,v 1.2 2006/09/20 17:25:11 pythonhead Exp $

inherit distutils

DESCRIPTION="Several modules providing low level functionality shared among some python projects developed by logilab."
HOMEPAGE="http://www.logilab.org/projects/common/"
SRC_URI="ftp://ftp.logilab.org/pub/common/${P#logilab-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~sparc ~x86"
IUSE="doc"

DEPEND="|| ( >=dev-python/optik-1.4 >=dev-lang/python-2.3 )"

S=${WORKDIR}/${P#logilab-}

PYTHON_MODNAME="logilab"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-remove-broken-modutils-test.patch"
	# the permissions for this file are 400 in the tarball for no
	# obvious reason
	chmod 444 test/data/noendingnewline.py || die "chmod failed"
	epatch "${FILESDIR}/${PN}-setup.py.patch"
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/*
	fi
}

src_test() {
	# The tests will not work properly from the source dir, so do a
	# temporary install:
	local spath="test/lib/python"
	"${python}" setup.py install --home="${T}/test" || die "test copy failed"
	# dir needs to be this or the tests fail
	cd "${T}/${spath}/logilab/common/test"
	PYTHONPATH="${T}/${spath}" "${python}" runtests.py || die "tests failed"
	cd "${S}"
	rm -rf "${T}/test"
}
