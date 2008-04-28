# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvrinput/vdr-pvrinput-0.1.1.ebuild,v 1.7 2008/04/28 09:13:14 zzam Exp $

inherit vdr-plugin eutils

IUSE=""

DESCRIPTION="VDR Plugin: Use a PVR* card as input device"
HOMEPAGE="http://home.arcor.de/andreas.regel/files/pvrinput/"
SRC_URI="http://home.arcor.de/andreas.regel/files/pvrinput/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-video/vdr-1.2.6"
RDEPEND="${DEPEND}
		>=media-tv/ivtv-0.4.0"

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
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
