# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qtpfsgui/qtpfsgui-1.9.1-r1.ebuild,v 1.2 2008/05/02 22:27:40 maekke Exp $

EAPI="1"

inherit eutils qt4

DESCRIPTION="Qtpfsgui is a graphical user interface that provides a workflow for HDR imaging."
HOMEPAGE="http://qtpfsgui.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	media-gfx/dcraw
	>=media-gfx/exiv2-0.14
	>=media-libs/jpeg-6b-r7
	>=media-libs/openexr-1.2.2-r2
	>=media-libs/tiff-3.8.2-r2
	>=sci-libs/fftw-3.0.1-r2
	|| ( ( x11-libs/qt-core:4 x11-libs/qt-gui:4 )
		>=x11-libs/qt-4.2.3-r1 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# no insane CXXFLAGS
	sed -i -e '/QMAKE_CXXFLAGS/d' project.pro || die
}

src_compile() {
	lrelease project.pro || die
	eqmake4 project.pro PREFIX=/usr || die
	emake || die
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
}
