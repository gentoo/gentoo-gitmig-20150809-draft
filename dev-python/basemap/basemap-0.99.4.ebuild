# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/basemap/basemap-0.99.4.ebuild,v 1.2 2009/12/01 06:03:45 bicatali Exp $

EAPI=2
inherit eutils distutils

DESCRIPTION="matplotlib toolkit to plot map projections"
HOMEPAGE="http://matplotlib.sourceforge.net/basemap/doc/html/"
SRC_URI="mirror://sourceforge/matplotlib/${P}.tar.gz"

IUSE="examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT GPL-2"

CDEPEND="sci-libs/shapelib
	>=dev-python/matplotlib-0.98
	>=sci-libs/geos-2.2.3"

DEPEND="${CDEPEND}
	dev-python/setuptools"

RDEPEND="${CDEPEND}
	>=dev-python/pupynere-1.0.8
	dev-python/dap"

DOCS="FAQ API_CHANGES"

src_prepare() {
	# use system libraries
	epatch "${FILESDIR}"/${PN}-0.99.3-syslib.patch
	epatch "${FILESDIR}"/${PN}-0.99.3-datadir.patch
	rm -f lib/mpl_toolkits/basemap/pupynere.py || die
	# quick sed to match upstream
	sed -i \
		-e 's/NumpyTestCase/TestCase/g' \
		lib/mpl_toolkits/basemap/test.py || die
}

src_install() {
	distutils_src_install --install-data=/usr/share/${PN}
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
	# clean up collision with matplotlib
	rm "${D}"/usr/lib*/python*/site-packages/mpl_toolkits/__init__.py || die
	# respect FHS
	mv "${D}"/usr/lib*/python*/site-packages/mpl_toolkits/basemap/data \
		"${D}"/usr/share/basemap || die
}
