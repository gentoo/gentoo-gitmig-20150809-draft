# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvrinput/vdr-pvrinput-0.1.1_pre1.ebuild,v 1.3 2006/05/08 06:51:48 zzam Exp $
inherit vdr-plugin

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="Plugin to use a PVR* card as input device for VDR"
HOMEPAGE="http://home.arcor.de/andreas.regel/files/pvrinput/"
SRC_URI="http://home.arcor.de/andreas.regel/files/pvrinput/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-video/vdr-1.2.6"
RDEPEND="${DEPEND}
		>=media-tv/ivtv-0.4.0"

S=${WORKDIR}/${MY_P#vdr-}

PATCHES="${FILESDIR}/${P}-include-order.patch"

src_install() {
	vdr-plugin_src_install

	dodoc examples/channels.conf.example
}
