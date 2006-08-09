# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-audiorecorder/vdr-audiorecorder-0.1.0_pre4-r1.ebuild,v 1.1 2006/08/09 17:28:20 zzam Exp $

inherit vdr-plugin

MY_P=${P/_pre/-pre}

DESCRIPTION="VDR plugin: automatically record radio-channels and split it into tracks according to RadioText-Info"
HOMEPAGE="http://www.vdr-portal.de/board/thread.php?threadid=52366"
SRC_URI="mirror://gentoo/${MY_P}.tgz"

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

PATCHES="${FILESDIR}/${P}-gcc4.diff
		${FILESDIR}/${P}-free_check.diff"

src_unpack() {
	vdr-plugin_src_unpack

	local TAGLIB=0
	use taglib && TAGLIB=1
	sed -i "${S}/Makefile" \
		-e'/^TAGLIB/s#=.*$#= '"${TAGLIB}#"
}

src_install() {
	vdr-plugin_src_install
	keepdir /var/vdr/audiorecorder
	chown -R vdr:vdr ${D}/var/vdr
}

