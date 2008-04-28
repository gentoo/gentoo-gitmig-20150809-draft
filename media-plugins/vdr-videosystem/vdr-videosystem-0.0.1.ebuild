# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-videosystem/vdr-videosystem-0.0.1.ebuild,v 1.5 2008/04/28 09:06:26 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Switch OSD resolution depending on signal-videosystem (PAL/NTSC)"
HOMEPAGE="http://www.vdr-portal.de/board/thread.php?threadid=43516"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"

PATCHES=("${FILESDIR}/${P}-uint64.diff")
