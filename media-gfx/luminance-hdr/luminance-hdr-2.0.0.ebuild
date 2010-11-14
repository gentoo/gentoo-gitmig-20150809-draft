# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/luminance-hdr/luminance-hdr-2.0.0.ebuild,v 1.5 2010/11/14 17:02:55 fauli Exp $

EAPI="2"

LANGS="cs de es fr hu id it pl ru tr"
inherit qt4-r2

OLD_PN="qtpfsgui"

DESCRIPTION="Luminance HDR is a graphical user interface that provides a workflow for HDR imaging."
HOMEPAGE="http://qtpfsgui.sourceforge.net"
SRC_URI="mirror://sourceforge/${OLD_PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="debug openmp"

DEPEND="
	media-gfx/dcraw
	>=media-gfx/exiv2-0.14
	>=media-libs/openexr-1.2.2-r2
	>=media-libs/tiff-3.8.2-r2
	>=sci-libs/fftw-3.0.1-r2
	sci-libs/gsl
	>=sys-devel/gcc-4.2[openmp?]
	virtual/jpeg
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"

DOCS="AUTHORS Changelog README TODO"

S="${WORKDIR}/${PN}_${PV}"

src_prepare() {
	qt4-r2_src_prepare

	# no insane CXXFLAGS
	sed -i -e '/QMAKE_CXXFLAGS/d' project.pro || die

	if ! use openmp ; then
		sed -i -e '/QMAKE_LFLAGS/d' project.pro || die
	fi
}

src_configure() {
	lrelease project.pro || die
	eqmake4 project.pro \
		PREFIX=/usr \
		ENABLE_DEBUG="$(use debug && echo YES || echo NO)"
}

src_install() {
	qt4-r2_src_install

	for lang in ${LANGS} ; do
		use linguas_${lang} || rm "${D}"/usr/share/luminance/i18n/lang_${lang}.qm
	done
}
