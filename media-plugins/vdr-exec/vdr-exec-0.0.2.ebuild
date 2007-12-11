# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-exec/vdr-exec-0.0.2.ebuild,v 1.1 2007/12/11 22:51:22 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Exec commands like timers at defined times"
HOMEPAGE="http://wirbel.htpc-forum.de/exec/index2.html"
SRC_URI="http://wirbel.htpc-forum.de/exec/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-video/vdr"

