# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dxr3/vdr-dxr3-0.2.9.ebuild,v 1.1 2009/01/05 23:57:01 hd_brummy Exp $

inherit vdr-plugin versionator

DESCRIPTION="VDR plugin: Use a dxr3 or hw+ card as output device"
HOMEPAGE="http://sourceforge.net/projects/dxr3plugin/"
SRC_URI="mirror://sourceforge/dxr3plugin/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-video/em8300-libraries
	>=media-video/vdr-1.6.0
	media-video/ffmpeg"

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
	sed -i Makefile -e 's:^FFMDIR =.*$:FFMDIR=/usr/include/ffmpeg:'

	if has_version ">=media-video/ffmpeg-0.4.9_p20080326"; then
		epatch "${FILESDIR}/${PN}-0.2.8-ffmpeg-includes.diff"
	fi
}
