# Copyright 2004-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-subtitles/vdr-subtitles-0.5.0.ebuild,v 1.2 2007/08/25 20:44:04 zzam Exp $

inherit vdr-plugin eutils

IUSE=""

DESCRIPTION="VDR Plugin: Decode and display DVB subtitles"
HOMEPAGE="http://virtanen.org/vdr/subtitles/"
SRC_URI="http://virtanen.org/vdr/subtitles/files/${P}.tgz
		http://www.saunalahti.fi/~rahrenbe/vdr/patches/${P}-purkkapaikka.diff.gz
		mirror://vdrfiles/${PN}/${P}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.7"

pkg_setup() {
	if [[ ! -f /usr/include/vdr/dvbsub.h ]]; then
		eerror "please compile VDR with USE=\"subtitles\""
		die "can not compile packet without subtitles-support from vdr"
	fi
	vdr-plugin_pkg_setup
}

src_unpack() {
	vdr-plugin_src_unpack unpack

	cd "${S}"
	if has_version ">=media-video/vdr-1.5.8"; then
		epatch "${WORKDIR}/${P}-purkkapaikka.diff"
	fi
	fix_vdr_libsi_include subfilter.c

	vdr-plugin_src_unpack all_but_unpack
}
