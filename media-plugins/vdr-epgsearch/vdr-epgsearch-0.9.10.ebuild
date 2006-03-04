# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-epgsearch/vdr-epgsearch-0.9.10.ebuild,v 1.3 2006/03/04 20:01:32 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder epgsearch plugin"
HOMEPAGE="http://www.cwieninger.de.vu/html/vdr-epg-search.html"
SRC_URI="http://people.freenet.de/cwieninger/${P}.tgz
		mirror://vdrfiles/${PN}/${P#vdr-}.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.7"

PATCHES="${DISTDIR}/${P#vdr-}.patch"
