# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dxr3/vdr-dxr3-0.2.6.ebuild,v 1.5 2007/07/10 23:08:59 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Use a dxr3 or hw+ card as output device"
HOMEPAGE="http://sourceforge.net/projects/dxr3plugin/"
SRC_URI="mirror://sourceforge/dxr3plugin/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="media-video/em8300-libraries
		>=media-video/vdr-1.3.36
		media-video/ffmpeg"

PATCHES="${FILESDIR}/${P}-polish.patch"

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	sed -i Makefile -e 's:^FFMDIR =.*$:FFMDIR=/usr/include/ffmpeg:'

	if has_version "<media-video/vdr-1.3.42"; then
		sed -i dxr3i18n.c -e '/\(Czech\)/d'
		sed -i dxr3.c -e '/VDRVERSNUM && VDRVERSNUM/s:10342:10336:'
	fi
}
