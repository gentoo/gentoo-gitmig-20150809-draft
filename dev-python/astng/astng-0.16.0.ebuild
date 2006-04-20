# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/astng/astng-0.16.0.ebuild,v 1.1 2006/04/20 12:29:07 marienz Exp $

inherit distutils eutils

DESCRIPTION="Abstract Syntax Tree New Generation for logilab packages"
SRC_URI="ftp://ftp.logilab.org/pub/astng/${P}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/astng/"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
DEPEND=">=dev-lang/python-2.1
	>=dev-python/logilab-common-0.13-r1"


src_unpack() {
	unpack ${A}
	cd "${S}"
	# 0.16.0 introduces a (most likely intentionally) failing test, revert it
	# to the (passing) 0.15.0 version.
	epatch "${FILESDIR}/${P}-revert-test.patch"
}

src_install() {
	distutils_src_install
	python_version
	# we need to remove this file because it collides with the one
	# from logilab-common (which we depend on).
	rm "${D}/usr/$(get_libdir)/python${PYVER}/site-packages/logilab/__init__.py"
}

src_test() {
	# The tests will not work properly from the source dir, so do a
	# temporary install.

	python_version
	local spath="usr/$(get_libdir)/python${PYVER}/site-packages/"
	# This is a hack to make tests work without installing to the live
	# filesystem. We copy part of the logilab site-packages to a temporary
	# dir, install there, and run from there.
	mkdir -p "${T}/test/${spath}/logilab"
	cp -r "${ROOT}${spath}/logilab/common" "${T}/test/${spath}/logilab" \
		|| die "copying logilab-common failed!"

	"${python}" setup.py install --root="${T}/test" || die "test copy failed"
	# dir needs to be this or the tests fail
	cd "${T}/test/${spath}/logilab/astng/test"
	PYTHONPATH="${T}/test/${spath}" "${python}" runtests.py \
		|| die "tests failed"
	cd "${S}"
	rm -rf "${T}/test"
}
