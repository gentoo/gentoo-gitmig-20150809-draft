# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dxr3/vdr-dxr3-0.2.7.20071111.ebuild,v 1.1 2007/11/11 20:49:29 hd_brummy Exp $

inherit vdr-plugin versionator

MY_PV=$(get_version_component_range 4)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="VDR plugin: Use a dxr3 or hw+ card as output device"
HOMEPAGE="http://sourceforge.net/projects/dxr3plugin/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-video/em8300-libraries
		>=media-video/vdr-1.3.42
		media-video/ffmpeg"

S="${WORKDIR}/${VDRPLUGIN}"

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
	sed -i Makefile -e 's:^FFMDIR =.*$:FFMDIR=/usr/include/ffmpeg:'
}
