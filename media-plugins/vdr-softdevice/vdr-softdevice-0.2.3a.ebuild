# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-softdevice/vdr-softdevice-0.2.3a.ebuild,v 1.1 2006/05/10 15:55:36 zzam Exp $

inherit vdr-plugin
DESCRIPTION="VDR plugin: Software output-Device"
HOMEPAGE="http://softdevice.berlios.de/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="xv fbcon directfb"

RDEPEND=">=media-video/vdr-1.3.36
	>=media-video/ffmpeg-0.4.9_pre1
	directfb? (
		dev-libs/DirectFB
		dev-libs/DFB++
	)
	media-libs/alsa-lib
	xv? ( || ( ( x11-libs/libX11
				x11-libs/libXext
				x11-libs/libXi
				x11-libs/libXv
			)
			virtual/x11
		) )"

DEPEND="${RDEPEND}
	xv? ( || ( ( x11-proto/xproto
				x11-proto/xextproto
			)
			virtual/x11
	) )
	fbcon? ( sys-kernel/linux-headers )"


PATCHES="${FILESDIR}/${P}-Makefile.diff"

disable_in_makefile() {
	local makefile_define="${1}"
	sed -i Makefile -e "s-^${makefile_define}-#${makefile_define}-"
}

src_unpack() {
	vdr-plugin_src_unpack

	disable_in_makefile VIDIX_SUPPORT
	use xv || disable_in_makefile XV_SUPPORT
	use directfb || disable_in_makefile DFB_SUPPORT
	use fbcon || disable_in_makefile FB_SUPPORT
}

src_install() {
	vdr-plugin_src_install

	insinto "${VDR_PLUGIN_DIR}"
	doins libsubvdr-*.so.*
}

