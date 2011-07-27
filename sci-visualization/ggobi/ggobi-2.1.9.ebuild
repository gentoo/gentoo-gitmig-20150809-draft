# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/ggobi/ggobi-2.1.9.ebuild,v 1.1 2011/07/27 22:47:47 bicatali Exp $

EAPI=4
inherit eutils autotools

DESCRIPTION="Visualization program for exploring high-dimensional data"
HOMEPAGE="http://www.ggobi.org/"
SRC_URI="http://www.ggobi.org/downloads/${P}.tar.bz2"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal nls"

RDEPEND="media-gfx/graphviz
	x11-libs/gtk+:2
	dev-libs/libxml2:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e 's|ND_coord_i|ND_coord|' \
		plugins/GraphLayout/graphviz.c || die
	#local f
	#for f in $(find "${S}" -name "configure.ac"); do
	#	sed -i -e '/AM_INIT/ a\AM_MAINTAINER_MODE' $f || die #342747
	#done
	#eautoreconf
}

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_with !minimal all-plugins)
}

src_compile() {
	emake all ggobirc
}

src_install() {
	default
	insinto /etc/xdg/ggobi
	doins ggobirc
}
