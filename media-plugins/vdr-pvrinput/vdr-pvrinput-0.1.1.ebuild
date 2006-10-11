# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvrinput/vdr-pvrinput-0.1.1.ebuild,v 1.4 2006/10/11 20:53:40 zzam Exp $

inherit vdr-plugin

IUSE=""

DESCRIPTION="Plugin to use a PVR* card as input device for VDR"
HOMEPAGE="http://home.arcor.de/andreas.regel/files/pvrinput/"
SRC_URI="http://home.arcor.de/andreas.regel/files/pvrinput/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.2.6"
RDEPEND="${DEPEND}
		>=media-tv/ivtv-0.4.0"

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	if has_version "<sys-kernel/linux-headers-2.6.17-r1"; then
		epatch "${FILESDIR}/${P}-include-order.patch"
	else
		# magically works without action
		:
	fi
}

src_install() {
	vdr-plugin_src_install

	dodoc examples/channels.conf.example
}
