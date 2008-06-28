# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytables/pytables-2.0.3.ebuild,v 1.1 2008/06/28 19:30:55 pythonhead Exp $

EAPI="1"
NEED_PYTHON="2.2"

inherit distutils multilib

DESCRIPTION="A package for managing hierarchical datasets built on top of the HDF5 library."
SRC_URI="http://www.pytables.org/download/stable/${P}.tar.gz"
HOMEPAGE="http://www.pytables.org/"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="BSD"
IUSE="doc examples"

DEPEND=">=sci-libs/hdf5-1.6.5
	>=dev-python/numpy-1.0.3
	dev-libs/lzo:2
	app-arch/bzip2"
RDEPEND="${DEPEND}"

src_install() {
	DOCS="ANNOUNCE.txt MIGRATING_TO_2.x.txt RELEASE_NOTES.txt THANKS TODO.txt"

	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	if use doc; then
		cd doc

		dohtml -r html/*

		docinto text
		dodoc text/*

		insinto /usr/share/doc/${PF}
		doins -r usersguide.pdf scripts/
	fi
}

src_test() {
	python_version
	"${python}" setup.py install --root="${T}" --no-compile "$@" || die "temporary install failed"
	PYTHONPATH="${T}/usr/$(get_libdir)/python${PYVER}/site-packages" "${python}" tables/tests/test_all.py || die "tests failed"
}
