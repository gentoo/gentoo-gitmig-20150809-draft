# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/picturewall/picturewall-1.0.ebuild,v 1.1 2010/05/04 19:55:13 hwoarang Exp $

EAPI="2"

inherit qt4-r2
MY_PN="PictureWall"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Qt4 picture viewer and image searching tool using google.com"
HOMEPAGE="http://www.qt-apps.org/content/show.php?content=106101"
SRC_URI="http://picturewall.googlecode.com/files/PictureWall_1.0.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/qt-gui-4.5.3"
DEPEND="app-arch/unzip
	${RDEPEND}"

S="${WORKDIR}/${MY_PN}/${MY_PN}"

src_install(){
	dobin bin/${PN} || die "dobin failed"
	dodoc ReadMe || die "dodoc failed"
	dohtml -r doc/html/* || die "dohtml failed"
}
