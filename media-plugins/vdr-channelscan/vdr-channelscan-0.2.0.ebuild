# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-channelscan/vdr-channelscan-0.2.0.ebuild,v 1.3 2006/04/17 17:08:10 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Channel Scanner"
HOMEPAGE="http://www.reel-multimedia.com"
SRC_URI="mirror://gentoo/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="x86"

DEPEND=">=media-video/vdr-1.3.18"

pkg_setup()
{
	vdr-plugin_pkg_setup
	if ! grep -q scanning_on_receiving_device ${ROOT}/usr/include/vdr/device.h; then
		ewarn "your vdr needs to be patched to use vdr-channelscan"
		die "unpatched vdr detected"
	fi
}

src_unpack() {
	vdr-plugin_src_unpack
	sed -e 's-libsi/-vdr/libsi/-g' -i filter.h
}

src_install() {
	vdr-plugin_src_install

	cd ${S}/transponders
	insinto /usr/share/vdr/channelscan/transponders
	doins *.tpl

	insinto /etc/vdr/plugins
	dosym /usr/share/vdr/channelscan/transponders /etc/vdr/plugins/transponders
}
