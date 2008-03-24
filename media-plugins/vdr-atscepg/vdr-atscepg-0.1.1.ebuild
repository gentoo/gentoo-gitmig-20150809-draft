# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-atscepg/vdr-atscepg-0.1.1.ebuild,v 1.1 2008/03/24 09:55:01 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: implements the Program and System Information
Protocol for DVB-T and DVB-C Broadcast from the ATSC standard"
HOMEPAGE="http://www.fepg.org/atscepg.html"
SRC_URI="http://www.fepg.org/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6"

pkg_setup() {

	if ! built_with_use media-video/vdr atsc; then
		echo
		ewarn "To support this plugin you need to"
		ewarn "recompile media-video/vdr with use-flag atsc"
		echo
	fi
}

src_unpack() {
	vdr-plugin_src_unpack

	fix_vdr_libsi_include tables.cpp
}
