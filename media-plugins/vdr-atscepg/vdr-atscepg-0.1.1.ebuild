# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-atscepg/vdr-atscepg-0.1.1.ebuild,v 1.2 2009/07/08 19:21:05 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: implements the Program and System Information
Protocol for DVB-T and DVB-C Broadcast from the ATSC standard"
HOMEPAGE="http://www.fepg.org/atscepg.html"
SRC_URI="http://www.fepg.org/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6"
RDEPEND="${DEPEND}"

pkg_setup() {
	vdr-plugin_pkg_setup

	if ! built_with_use media-video/vdr atsc; then
		echo
		ewarn "To support this plugin you need to"
		ewarn "recompile media-video/vdr with use-flag atsc"
		echo
	fi
}

src_unpack() {
	vdr-plugin_src_unpack

	epatch "${FILESDIR}/${P}-gcc-4.4.diff"
	fix_vdr_libsi_include tables.cpp
}
