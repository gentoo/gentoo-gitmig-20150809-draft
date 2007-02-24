# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/basemap/basemap-0.9.4.ebuild,v 1.1 2007/02/24 01:02:33 bicatali Exp $

inherit distutils

DESCRIPTION="matplotlib toolkit to plot map projections"
HOMEPAGE="http://matplotlib.sourceforge.net/matplotlib.toolkits.basemap.basemap.html"
SRC_URI="mirror://sourceforge/matplotlib/${P}.tar.gz"

IUSE="examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT GPL-2"
RESTRICT="test"

DEPEND="sci-libs/shapelib
	sci-libs/proj"

RDEPEND="${DEPEND}
	>=dev-python/matplotlib-0.87.3
	dev-python/basemap-data"

DOCS="FAQ"

src_unpack() {
	unpack ${A}
	# patch to use proj and shapelib system libraries
	epatch "${FILESDIR}/${PN}-syslib.patch"
	cd "${S}"
	mv src/pyproj.* .
	rm -rf src
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
