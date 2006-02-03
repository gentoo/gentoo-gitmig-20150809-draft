# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-epgsearch/vdr-epgsearch-0.9.10.ebuild,v 1.1 2006/02/03 12:28:33 zzam Exp $

inherit vdr-plugin eutils

RESTRICT="nomirror"
DESCRIPTION="Video Disk Recorder epgsearch plugin"
HOMEPAGE="http://www.cwieninger.de.vu/html/vdr-epg-search.html"
SRC_URI="http://people.freenet.de/cwieninger/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz
		mirror://vdrfiles/${PN}/${P#vdr-}.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.7"

src_unpack() {
	vdr-plugin_src_unpack
	epatch "${DISTDIR}/${P#vdr-}.patch"
}
