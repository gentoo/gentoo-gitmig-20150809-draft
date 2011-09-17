# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvrinput/vdr-pvrinput-2011.08.18.ebuild,v 1.1 2011/09/17 09:39:28 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin eutils versionator

VERSION="668" # every bump, new version!

MY_PV=$(replace_all_version_separators '-')
MY_P="${PN}-${MY_PV}"

DESCRIPTION="VDR Plugin: Use a PVR* card as input device"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-pvrinput"
SRC_URI="http://projects.vdr-developer.org/attachments/download/${VERSION}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P#vdr-}"

src_prepare() {
	vdr-plugin_src_prepare

	fix_vdr_libsi_include reader.c
}

src_install() {
	vdr-plugin_src_install

	dodoc TODO FAQ example/channels.conf_*
}
