# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-audiorecorder/vdr-audiorecorder-0.1.0_pre6.ebuild,v 1.1 2006/09/07 20:08:56 zzam Exp $

inherit vdr-plugin

MY_P=${P/_pre/-pre}

DESCRIPTION="VDR plugin: automatically record radio-channels and split it into tracks according to RadioText-Info"
HOMEPAGE="http://www.a-land.de/audiorecorder/"
SRC_URI="http://www.a-land.de/audiorecorder/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="taglib"

S=${WORKDIR}/${MY_P#vdr-}

DEPEND=">=media-video/vdr-1.3.31
		taglib? ( media-libs/taglib )
		>=media-video/ffmpeg-0.4.9
		"

RDEPEND="${DEPEND}"

src_unpack() {
	vdr-plugin_src_unpack

	# delete definition of TAGLIB when USE=-taglib
	use taglib || sed -i "${S}/Makefile" -e '/^TAGLIB/d'
}

src_install() {
	vdr-plugin_src_install
	keepdir /var/vdr/audiorecorder
	chown -R vdr:vdr ${D}/var/vdr
}

