# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xvideoservicethief/xvideoservicethief-2.0.0-r1.ebuild,v 1.1 2009/06/08 18:55:02 ssuominen Exp $

EAPI=2
inherit eutils qt4 versionator

MY_PN=xVST
MY_PV=$(replace_all_version_separators '_')
MY_P=${MY_PN}_${MY_PV}a_src

DESCRIPTION="Download (and convert) videos from various Web Video Services"
HOMEPAGE="http://xviservicethief.sourceforge.net/"
SRC_URI="mirror://sourceforge/xviservicethief/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="app-arch/unzip
	>=x11-libs/qt-gui-4.5.0:4"
RDEPEND=">=x11-libs/qt-gui-4.5.0:4
	media-video/ffmpeg"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-plugins_path.patch
}

# TODO: translations, documentation
src_configure() {
	eqmake4 xVideoServiceThief.pro
}

src_install() {
	dobin bin/xvst || die "dobin failed"
	local dest=/usr/share/${PN}/plugins
	dodir ${dest}
	find resources/services -name '*.js' -exec cp -dpR {} ${D}${dest} \;
	dodoc changelog.txt
	newicon resources/images/InformationLogo.png xvst.png
	make_desktop_entry /usr/bin/xvst xVideoServiceThief xvst 'Qt;AudioVideo;Video'
}
