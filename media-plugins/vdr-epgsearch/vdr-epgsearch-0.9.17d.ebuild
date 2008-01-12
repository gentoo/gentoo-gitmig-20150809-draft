# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-epgsearch/vdr-epgsearch-0.9.17d.ebuild,v 1.5 2008/01/12 11:57:34 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder epgsearch plugin"
HOMEPAGE="http://freenet-homepage.de/cwieninger/html/vdr-epg-search.html"
SRC_URI="http://people.freenet.de/cwieninger/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.45"

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
	fix_vdr_libsi_include conflictcheck.c
}
