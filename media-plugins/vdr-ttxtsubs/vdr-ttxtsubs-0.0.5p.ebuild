# Copyright 2004-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ttxtsubs/vdr-ttxtsubs-0.0.5p.ebuild,v 1.1 2006/03/22 10:03:36 zzam Exp $

inherit vdr-plugin eutils versionator

IUSE=""

MY_P=${PN}-$(get_version_component_range 1-3)
PATCHNAME=${MY_P}-pilikumi-edition

DESCRIPTION="Video Disk Recorder Teletext-Subtitles PlugIn"
HOMEPAGE="ftp://ftp.nada.kth.se/pub/home/ragge/vdr"
SRC_URI="ftp://ftp.nada.kth.se/pub/home/ragge/vdr/${MY_P}.tgz
		http://www.saunalahti.fi/~rahrenbe/vdr/patches/${PATCHNAME}.diff.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.19"

S=${WORKDIR}/${MY_P#vdr-}

pkg_setup() {
	if [[ ! -f ${ROOT}/usr/include/vdr/vdrttxtsubshooks.h ]]; then
		eerror "please compile vdr with USE=\"subtitles\""
		die "can not compile packet without subtitles-support from vdr"
	fi
	vdr-plugin_pkg_setup
}

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	epatch ${WORKDIR}/${PATCHNAME}.diff
	sed -i ${S}/Makefile -e '/Checkpatch.sh/d'
}
