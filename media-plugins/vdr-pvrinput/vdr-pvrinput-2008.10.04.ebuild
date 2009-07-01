# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvrinput/vdr-pvrinput-2008.10.04.ebuild,v 1.2 2009/07/01 06:54:08 zzam Exp $

inherit vdr-plugin eutils versionator

IUSE=""

MY_P="${PN}-${PV//./-}"

DESCRIPTION="VDR Plugin: Use a PVR* card as input device"
HOMEPAGE="http://drseltsam.device.name/vdr/pvr/src/pvrinput"
SRC_URI="http://drseltsam.device.name/vdr/pvr/src/pvrinput/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.2.6"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P#vdr-}"

src_install() {
	vdr-plugin_src_install

	dodoc TODO FAQ example/channels.conf_*
}
