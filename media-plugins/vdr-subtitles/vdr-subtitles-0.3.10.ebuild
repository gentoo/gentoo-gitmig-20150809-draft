# Copyright 2004-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-subtitles/vdr-subtitles-0.3.10.ebuild,v 1.4 2006/04/24 20:38:32 zzam Exp $

inherit vdr-plugin eutils

IUSE=""

DESCRIPTION="Video Disk Recorder Subtitles PlugIn"
HOMEPAGE="http://virtanen.org/vdr/subtitles/"
SRC_URI="http://virtanen.org/vdr/subtitles/files/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.7"

pkg_setup() {
	if [[ ! -f ${ROOT}/usr/include/vdr/dvbsub.h ]]; then
		eerror "please compile vdr with USE=\"subtitles\""
		die "can not compile packet without subtitles-support from vdr"
	fi
	vdr-plugin_pkg_setup
}

src_unpack() {
	vdr-plugin_src_unpack

	sed -i subfilter.c \
		-e "s:libsi/:vdr/libsi/:"
}
