# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-reelchannelscan/vdr-reelchannelscan-0.4.3-r1.ebuild,v 1.1 2007/05/21 10:12:42 zzam Exp $

inherit vdr-plugin

DESCRIPTION="vdr Plugin: Channel Scanner"
HOMEPAGE="http://www.reel-multimedia.com"
SRC_URI="mirror://gentoo/${P}.tgz
	http://dev.gentoo.org/~zzam/distfiles/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"

pkg_setup(){
	vdr-plugin_pkg_setup

	if ! grep -q scanning_on_receiving_device ${ROOT}/usr/include/vdr/device.h; then
		ewarn "your vdr needs to be patched to use vdr-channelscan"
		die "unpatched vdr detected"
	fi
}

src_unpack() {
	vdr-plugin_src_unpack
	epatch "${FILESDIR}/${PV}/gentoo.diff"

	fix_vdr_libsi_include filter.[ch]
}

src_install() {
	vdr-plugin_src_install

	cd ${S}/transponders
	insinto /usr/share/vdr/reelchannelscan/transponders
	doins *.tpl
}
