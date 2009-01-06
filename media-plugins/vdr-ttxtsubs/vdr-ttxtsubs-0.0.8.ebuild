# Copyright 2004-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ttxtsubs/vdr-ttxtsubs-0.0.8.ebuild,v 1.1 2009/01/06 18:14:17 hd_brummy Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR Plugin: displaying, recording and replaying teletext
based subtitles"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-ttxtsubs"
SRC_URI="http://projects.vdr-developer.org/attachments/download/39/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.5.8"

pkg_setup() {
	if [[ ! -f /usr/include/vdr/vdrttxtsubshooks.h ]]; then
		eerror "please compile vdr with USE=\"ttxtsubs\""
		die "can not compile packet without subtitles-support from vdr"
	fi
	vdr-plugin_pkg_setup
}
