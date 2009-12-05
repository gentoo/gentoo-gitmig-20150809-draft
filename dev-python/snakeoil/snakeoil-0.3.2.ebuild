# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snakeoil/snakeoil-0.3.2.ebuild,v 1.8 2009/12/05 21:22:18 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Miscellaneous python utility code."
HOMEPAGE="http://www.pkgcore.org/"
SRC_URI="http://www.pkgcore.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""

DEPEND="!<sys-apps/pkgcore-0.4.7.8"
RDEPEND=${DEPEND}
RESTRICT_PYTHON_ABIS="3.*"

DOCS="AUTHORS NEWS"

pkg_setup() {
	validate_PYTHON_ABIS

	# A hack to install for all versions of Python 2 in the system.
	# pkgcore needs it to support upgrading to a different Python slot.
	PYTHON_ABIS=""
	local python_version
	for python_version in /usr/bin/python2.[4-9]; do
		PYTHON_ABIS+=" ${python_version#/usr/bin/python}"
	done
	export PYTHON_ABIS="${PYTHON_ABIS# }"
}

src_test() {
	testing() {
		local tempdir
		tempdir="${T}/tests/python-${PYTHON_ABI}"
		mkdir -p "${tempdir}" || die "tempdir creation failed"
		cp -r "${S}" "${tempdir}" || die "test copy failed"
		cd "${tempdir}/${P}"
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}
