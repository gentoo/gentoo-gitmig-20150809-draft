# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gdal-grass/gdal-grass-1.4.3-r1.ebuild,v 1.1 2010/06/13 09:20:01 scarabeus Exp $

EAPI=2
inherit eutils

DESCRIPTION="GDAL plugin to access GRASS data"
HOMEPAGE="http://www.gdal.org/"
SRC_URI="http://download.osgeo.org/gdal/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="sci-libs/gdal
	>=sci-geosciences/grass-6.4.0_rc6"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-makefile.patch"
}

src_configure() {
	econf --with-grass=$(pkg-config grass --variable grassdir) --with-gdal
}

src_install() {
	#pass the right variables to 'make install' to prevent a sandbox access violation
	emake DESTDIR="${D}" \
		GRASSTABLES_DIR="${D}$(gdal-config --prefix)/share/gdal/grass" \
		AUTOLOAD_DIR="${D}/usr/$(get_libdir)/gdalplugins" \
		install || die "emake install failure"
}
