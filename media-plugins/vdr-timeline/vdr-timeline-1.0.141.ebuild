# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-timeline/vdr-timeline-1.0.141.ebuild,v 1.4 2007/01/04 11:37:14 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Timeline PlugIn"
HOMEPAGE="http://www.js-home.org/vdr/timeline/"
SRC_URI="http://www.js-home.org:80/vdr/timeline/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

PATCHES="${FILESDIR}/${P}-german.diff
	${FILESDIR}/vdr-timeline-fix-crash-no-timer.diff"

DEPEND=">=media-video/vdr-1.4.1"

