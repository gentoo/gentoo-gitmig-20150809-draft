# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dvd/vdr-dvd-0.3.7_pre20060204.ebuild,v 1.1 2006/02/04 17:04:47 hd_brummy Exp $

inherit vdr-plugin

S="${WORKDIR}/dvd"

DESCRIPTION="Video Disk Recorder DVD-Player PlugIn"
HOMEPAGE="http://sourceforge.net/projects/dvdplugin"
SRC_URI="http://vdr.websitec.de/download/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.34
		>=media-libs/libdvdcss-1.2.8
		>=media-libs/libdvdnav-0.1.9
		>=media-libs/libdvdread-0.9.4
		>=media-libs/a52dec-0.7.4
		!media-plugins/vdr-dvd-cvs"

# DO NOT remove "!media-plugins/vdr-dvd-cvs" from DEPEND !!!
# It will fix a conflict with stored ebuilds in Gentoo.de OVERLAY CVS

src_unpack() {
vdr-plugin_src_unpack

	# Version number fix
	sed -i "s:0.3.6-b03:0.3.7-Pre:" dvd.h
}
