# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/merkaartor/merkaartor-9999.ebuild,v 1.7 2009/05/04 22:04:23 hanno Exp $

EAPI="1"

inherit eutils qt4 subversion

ESVN_REPO_URI="http://svn.openstreetmap.org/applications/editors/merkaartor/"

DESCRIPTION="A Qt4 based map editor for the openstreetmap.org project"
HOMEPAGE="http://www.merkaartor.org"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls webkit exif proj gdal"
DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	webkit? ( >=x11-libs/qt-webkit-4.3.3 )
	exif? ( media-gfx/exiv2 )
	proj? ( sci-libs/proj )
	gdal? ( sci-libs/gdal )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	local myconf
	use webkit || myconf="${myconf} NOUSEWEBKIT=1"
	use exif && myconf="${myconf} GEOIMAGE=1" || myconf="${myconf} GEOIMAGE=0"
	use proj && myconf="${myconf} PROJ=1" || myconf="${myconf} PROJ=0"
	use gdal && myconf="${myconf} GDAL=1" || myconf="${myconf} GDAL=0"

	if use nls; then
		lrelease Merkaartor.pro || die "lrelease failed"
	fi

	eqmake4 Merkaartor.pro PREFIX=/usr ${myconf} || die "eqmake4 failed"
	emake || die "make failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
	dodoc AUTHORS CHANGELOG HACKING || die "dodoc failed"

	newicon Icons/Mercator_100x100.png "${PN}".png || die "newicon failed"
	make_desktop_entry "${PN}" "Merkaartor" "${PN}" "Science;Geoscience"
}
