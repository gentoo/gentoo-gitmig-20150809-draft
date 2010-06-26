# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/astng/astng-0.20.1.ebuild,v 1.3 2010/06/26 18:23:11 angelos Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Abstract Syntax Tree New Generation for logilab packages"
HOMEPAGE="http://www.logilab.org/projects/astng/ http://pypi.python.org/pypi/logilab-astng"
SRC_URI="ftp://ftp.logilab.org/pub/astng/logilab-${P}.tar.gz http://pypi.python.org/packages/source/l/logilab-astng/logilab-${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos ~x86-macos"
IUSE="test"

# Version specified in __pkginfo__.py.
RDEPEND=">=dev-python/logilab-common-0.49.0"
DEPEND="${RDEPEND}
	test? ( >=dev-python/egenix-mx-base-3.0.0 )"

S="${WORKDIR}/logilab-${P}"

PYTHON_MODNAME="logilab/astng"

src_test() {
	testing() {
		local sdir="${T}/test/$(python_get_sitedir)"

		# This is a hack to make tests work without installing to the live
		# filesystem. We copy part of the logilab site-packages to a temporary
		# dir, install there, and run from there.
		mkdir -p "${sdir}/logilab" || die
		cp -r "$(python_get_sitedir)/logilab/common" "${sdir}/logilab" || die "copying logilab-common failed!"

		"$(PYTHON)" setup.py install --root="${T}/test" || die "test copy failed"

		# Pytest picks up tests relative to the current dir, so cd in.
		pushd "${sdir}/logilab/astng" > /dev/null || die
		PYTHONPATH="${sdir}" pytest -v || die "tests failed"
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	deletion_of_unneeded_files() {
		local sdir="${ED}$(python_get_sitedir)/logilab"

		# we need to remove this file because it collides with the one
		# from logilab-common (which we depend on).
		# Bug 111970 and bug 223025
		rm -f "${sdir}/__init__.py" || die

		# Remove unittests since they're just needed during build-time
		rm -fr "${sdir}/astng/test" || die
	}
	python_execute_function -q deletion_of_unneeded_files
}
