# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/basemap/basemap-1.0.2-r1.ebuild,v 1.1 2012/01/04 20:24:42 bicatali Exp $

EAPI=3
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils

DESCRIPTION="matplotlib toolkit to plot map projections"
HOMEPAGE="http://matplotlib.sourceforge.net/basemap/doc/html/ http://pypi.python.org/pypi/basemap"
SRC_URI="mirror://sourceforge/matplotlib/${P}.tar.gz"

IUSE="examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT GPL-2"

CDEPEND="sci-libs/shapelib
	>=dev-python/matplotlib-0.98
	>=sci-libs/geos-3.3.1"

DEPEND="${CDEPEND}
	dev-python/setuptools"

RDEPEND="${CDEPEND}
	>=dev-python/pupynere-1.0.8
	dev-python/httplib2
	dev-python/dap"

DOCS="FAQ API_CHANGES"

src_prepare() {
	# use /usr/share/data
	sed -i \
		-e "/_datadir.*=.*join/s|\(.*datadir.*=\).*|\1'${EROOT}usr/share/${PN}'|g" \
		"${S}"/lib/mpl_toolkits/basemap/*.py || die
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
		rm -f "${ED}$(python_get_sitedir)/mpl_toolkits/__init__.py"
		# respect FHS
		rm -fr "${ED}$(python_get_sitedir)/mpl_toolkits/basemap/data"
	}
	python_execute_function -q cleaning
}
