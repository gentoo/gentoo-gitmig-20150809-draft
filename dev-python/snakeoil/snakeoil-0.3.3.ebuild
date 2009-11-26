# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snakeoil/snakeoil-0.3.3.ebuild,v 1.1 2009/11/26 10:33:33 patrick Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Miscellaneous python utility code."
HOMEPAGE="http://www.pkgcore.org/"
SRC_URI="http://www.pkgcore.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DOCS="AUTHORS NEWS"
DEPEND="!<sys-apps/pkgcore-0.4.7.8"
RDEPEND=${DEPEND}

# Uses an ugly hack to install for all versions of python on the
# system. This should be supported through the eclass at some point.
# pkgcore needs it now to support upgrading to a different python slot.

src_compile() {
	local opython=${python}
	for python in /usr/bin/python2.[4-9]; do
		distutils_src_compile
	done
	python=${opython}
}

src_test() {
	local opython=${python} tempdir
	for python in /usr/bin/python2.[4-9]; do
		tempdir="${T}/tests/$(basename ${python})"
		mkdir -p "${tempdir}" || die "tempdir creation failed"
		cp -r "${S}" "${tempdir}" || die "test copy failed"
		cd "${tempdir}/${P}"
		"${python}" setup.py test || die "testing returned non zero"
	done
	python=${opython}
	rm -rf "${T}/tests"
}

src_install() {
	local opython=${python}
	for python in /usr/bin/python2.[4-9]; do
		distutils_src_install
	done
}
