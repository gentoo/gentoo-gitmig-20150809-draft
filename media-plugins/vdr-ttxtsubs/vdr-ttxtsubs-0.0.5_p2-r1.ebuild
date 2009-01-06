# Copyright 2004-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ttxtsubs/vdr-ttxtsubs-0.0.5_p2-r1.ebuild,v 1.5 2009/01/06 18:14:17 hd_brummy Exp $

inherit vdr-plugin eutils versionator

IUSE=""

MY_P=${PN}-$(get_version_component_range 1-3)
PATCHNAME_1_4="${MY_P}-lusikkahaarukka-edition"
PATCHNAME_1_5="${MY_P}-raastinrauta-edition"

DESCRIPTION="Video Disk Recorder Teletext-Subtitles PlugIn"
HOMEPAGE="ftp://ftp.nada.kth.se/pub/home/ragge/vdr"
SRC_URI="ftp://ftp.nada.kth.se/pub/home/ragge/vdr/${MY_P}.tgz
		 http://www.saunalahti.fi/~rahrenbe/vdr/patches/${PATCHNAME_1_4}.diff.gz
		 http://www.saunalahti.fi/~rahrenbe/vdr/patches/${PATCHNAME_1_5}.diff.gz"
KEYWORDS="~amd64 x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.19"

S=${WORKDIR}/${MY_P#vdr-}

pkg_setup() {
	if [[ ! -f /usr/include/vdr/vdrttxtsubshooks.h ]]; then
		local flag=ttxtsubs
		if has_version "<media-video/vdr-1.6.0"; then
			flag="subtitles"
		fi
		eerror "please compile vdr with USE=\"${flag}\""
		die "can not compile packet without subtitles-support from vdr"
	fi
	vdr-plugin_pkg_setup
}

src_unpack() {
	vdr-plugin_src_unpack unpack

	if has_version ">=media-video/vdr-1.5.8"; then
		epatch "${WORKDIR}/${PATCHNAME_1_5}.diff"
	else
		epatch "${WORKDIR}/${PATCHNAME_1_4}.diff"
	fi

	cd "${S}"
	sed -i "${S}"/Makefile -e '/Checkpatch.sh/d'

	vdr-plugin_src_unpack all_but_unpack
}
