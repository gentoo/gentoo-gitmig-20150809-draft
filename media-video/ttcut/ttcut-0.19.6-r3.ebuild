# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ttcut/ttcut-0.19.6-r3.ebuild,v 1.3 2011/07/15 21:15:39 maekke Exp $

EAPI=4

inherit fdo-mime qt4-r2

DESCRIPTION="Tool for cutting MPEG files especially for removing commercials"
HOMEPAGE="http://www.tritime.de/ttcut/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	>=media-libs/libmpeg2-0.4.0
	virtual/opengl"

RDEPEND="${DEPEND}
	media-video/mplayer
	>=virtual/ffmpeg-0.6.90[encode]"

S=${WORKDIR}/${PN}

PATCHES=( "${FILESDIR}"/${P}-deprecated.patch
			"${FILESDIR}"/${P}-ntsc-fps.patch
			"${FILESDIR}"/${P}-ffmpeg-vf-setdar.patch )

src_install() {
	dobin ttcut

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop

	dodoc AUTHORS BUGS CHANGELOG README.* TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
