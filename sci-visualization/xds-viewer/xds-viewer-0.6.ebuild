# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/xds-viewer/xds-viewer-0.6.ebuild,v 1.2 2011/06/15 09:11:26 jlec Exp $

EAPI=3

inherit cmake-utils

DESCRIPTION="Viewing X-ray diffraction and control images in the context of data processing by the XDS"
HOMEPAGE="http://xds-viewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	media-libs/libpng
	x11-libs/qt-gui"
DEPEND="
	dev-util/cmake
	${RDEPEND}"

DOCS="README"
HTML_DOCS="src/doc/*"
