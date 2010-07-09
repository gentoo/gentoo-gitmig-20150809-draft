# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/basemap/basemap-1.0.ebuild,v 1.2 2010/07/09 13:15:47 arfrever Exp $

EAPI=3
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

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
	>=sci-libs/geos-3.1.1"

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
}

src_install() {
	distutils_src_install --install-data="${EPREFIX}/usr/share/${PN}"

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi

	# respect FHS
	mv "${ED}$(python_get_sitedir -f)/mpl_toolkits/basemap/data" "${ED}usr/share/basemap"

	cleaning() {
		# clean up collision with matplotlib
		rm "${ED}$(python_get_sitedir)/mpl_toolkits/__init__.py" || return 1
		# respect FHS
		rm -r "${ED}$(python_get_sitedir)/mpl_toolkits/basemap/data"
	}
	python_execute_function -q cleaning
}
