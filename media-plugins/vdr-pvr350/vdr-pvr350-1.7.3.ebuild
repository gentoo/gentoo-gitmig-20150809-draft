# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvr350/vdr-pvr350-1.7.3.ebuild,v 1.1 2011/09/15 13:26:33 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin eutils

IUSE="yaepg"

DESCRIPTION="VDR plugin: use a PVR350 as output device"
HOMEPAGE="http://drseltsam.device.name/vdr/pvr/src/pvr350/"
SRC_URI="http://drseltsam.device.name/vdr/pvr/src/pvr350/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

S="${WORKDIR}/${P#vdr-}"

DEPEND=">=media-video/vdr-1.6.0
	media-sound/mpg123
	media-sound/twolame
	media-libs/a52dec"
RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
	|| ( >=sys-kernel/linux-headers-2.6.38 )"

pkg_setup() {
	vdr-plugin_pkg_setup

	if use yaepg; then
		elog "Checking for patched vdr"
		grep -q fontYaepg /usr/include/vdr/font.h
		eend $? "You need to emerge vdr with use-flag yaepg set!" || die "Unpatched vdr detected!"

		BUILD_PARAMS="SET_VIDEO_WINDOW=1"
	fi
}
