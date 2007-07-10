# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-audiorecorder/vdr-audiorecorder-0.1.0_pre6.ebuild,v 1.4 2007/07/10 23:08:59 mr_bones_ Exp $

inherit vdr-plugin

MY_P=${P/_pre/-pre}

DESCRIPTION="VDR plugin: automatically record radio-channels and split it into tracks according to RadioText-Info"
HOMEPAGE="http://www.a-land.de/audiorecorder/"
SRC_URI="http://www.a-land.de/audiorecorder/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/${MY_P#vdr-}

DEPEND=">=media-video/vdr-1.3.31
		media-libs/taglib
		>=media-video/ffmpeg-0.4.9
		"

RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${P}-vdr-1.5.0.diff"

src_install() {
	vdr-plugin_src_install
	keepdir /var/vdr/audiorecorder
	chown -R vdr:vdr ${D}/var/vdr
}
