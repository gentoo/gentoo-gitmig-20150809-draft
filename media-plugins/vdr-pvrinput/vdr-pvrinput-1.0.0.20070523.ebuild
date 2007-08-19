# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvrinput/vdr-pvrinput-1.0.0.20070523.ebuild,v 1.2 2007/08/19 11:17:49 zzam Exp $

inherit vdr-plugin eutils versionator

IUSE=""

MY_PV="$(replace_version_separator 3 '_' )"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="VDR Plugin: Use a PVR* card as input device"
HOMEPAGE="http://drseltsam.device.name/vdr/pvr/src/pvrinput"
SRC_URI="http://drseltsam.device.name/vdr/pvr/src/pvrinput/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.2.6"

S="${WORKDIR}/${MY_P#vdr-}"

src_install() {
	vdr-plugin_src_install

	dodoc example/channels.conf.example
}
