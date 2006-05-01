# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-channelscan/vdr-channelscan-0.3.0.ebuild,v 1.1 2006/05/01 19:26:34 hd_brummy Exp $

inherit vdr-plugin

MY_PN="vdr-reelchannelscan"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="vdr Plugin: Channel Scanner"
HOMEPAGE="http://www.reel-multimedia.com"
SRC_URI="http://www.reelbox.org/software/source/vdr-plugins/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"

S="${WORKDIR}/reelchannelscan-${PV}"

pkg_setup(){
	vdr-plugin_pkg_setup

	if ! grep -q scanning_on_receiving_device ${ROOT}/usr/include/vdr/device.h; then
		ewarn "your vdr needs to be patched to use vdr-channelscan"
		die "unpatched vdr detected"
	fi
}

src_unpack() {
	vdr-plugin_src_unpack

	sed -e "s:libsi/:vdr/libsi/:g" -i filter.h

	sed -e "s:PLUGIN = reelchannelscan:PLUGIN = channelscan:" -i Makefile
	mv reelchannelscan.c channelscan.c
}

src_install() {
	vdr-plugin_src_install

	cd ${S}/transponders
	insinto /usr/share/vdr/channelscan/transponders
	doins *.tpl

	insinto /etc/vdr/plugins
	dosym /usr/share/vdr/channelscan/transponders /etc/vdr/plugins/transponders
}
