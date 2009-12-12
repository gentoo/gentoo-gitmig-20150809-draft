# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytables/pytables-2.1.2.ebuild,v 1.1 2009/12/12 16:26:37 bicatali Exp $

EAPI=2
inherit eutils distutils

MYP="tables-${PV}"

DESCRIPTION="A package for managing hierarchical datasets built on top of the HDF5 library."
SRC_URI="http://www.pytables.org/download/stable/${MYP}.tar.gz"
HOMEPAGE="http://www.pytables.org/"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="BSD"
IUSE="doc examples"

DEPEND="sci-libs/hdf5
	dev-python/numpy
	dev-libs/lzo:2
	app-arch/bzip2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MYP}"

DOCS="ANNOUNCE.txt MIGRATING_TO_2.x.txt RELEASE_NOTES.txt THANKS"

src_prepare() {
	epatch "${FILESDIR}"/${P}-failingtests.patch
}

src_test() {
	cd build/lib*
	PYTHONPATH=. "${python}" tables/tests/test_all.py || die "tests failed"
}

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die
	fi
	if use doc; then
		cd doc
		dodoc text/* || die
		doins -r usersguide.pdf scripts html || die
	fi
}
