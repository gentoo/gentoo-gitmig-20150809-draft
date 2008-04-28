# Copyright 2003-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-osdpip/vdr-osdpip-0.0.9.ebuild,v 1.1 2008/04/28 19:17:57 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Show another channel in the OSD"
HOMEPAGE="http://www.magoa.net/linux"
SRC_URI="http://home.arcor.de/andreas.regel/files/${P}.tgz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0
	>=media-libs/libmpeg2-0.4.0
	>=media-video/ffmpeg-0.4.8
	"

#PATCHES=("${FILESDIR}/${P}-vdr-1.5.0.diff")

src_unpack() {
	vdr-plugin_src_unpack

	/bin/sed -i Makefile \
	  -e 's+^FFMDIR.*$+FFMDIR = /usr/include/ffmpeg+' \
	  -e 's+-I\$(FFMDIR)/libavcodec+-I$(FFMDIR)+' \
	  -e 's+-L\$(FFMDIR)/libavcodec++'

	if has_version ">=media-video/ffmpeg-0.4.9_p20080326" ; then
		epatch "${FILESDIR}/${P}-ffmpeg-0.4.9_p20080326-new_header.diff"
	fi
}
