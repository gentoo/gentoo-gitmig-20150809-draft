# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvrinput/vdr-pvrinput-2010.04.03_rc1.ebuild,v 1.1 2010/04/11 00:20:43 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin eutils versionator

MY_PV=$(replace_all_version_separators '-')
MY_P="${PN}-${MY_PV}"

DESCRIPTION="VDR Plugin: Use a PVR* card as input device"
HOMEPAGE="http://drseltsam.device.name/vdr/pvr/src/pvrinput"
SRC_URI="http://projects.vdr-developer.org/attachments/download/278/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P#vdr-}"

src_install() {
	vdr-plugin_src_install

	dodoc TODO FAQ example/channels.conf_*
}
