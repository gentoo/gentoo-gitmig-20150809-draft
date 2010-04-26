# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygsl/pygsl-0.9.4.ebuild,v 1.6 2010/04/26 20:19:43 maekke Exp $

EAPI=2
inherit eutils distutils

DESCRIPTION="A Python interface for the GNU scientific library (gsl)."
HOMEPAGE="http://pygsl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="examples"

DEPEND="sci-libs/gsl
	dev-python/numpy"
RDEPEND="${DEPEND}"

src_prepare() {
	has_version '>=sci-libs/gsl-1.13' && epatch "${FILESDIR}"/${P}-obsolete-units.patch
}

src_test() {
	cd "${S}/tests"
	PYTHONPATH=$(ls -d ../build/lib*) "${python}" run_test.py || die "tests failed"
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "install examples failed"
	fi
}
