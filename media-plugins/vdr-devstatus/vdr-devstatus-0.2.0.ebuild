# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-devstatus/vdr-devstatus-0.2.0.ebuild,v 1.1 2008/11/18 20:25:34 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: displays the usage status of the available devices."
HOMEPAGE="http://www.vdrportal.de/board/thread.php?postid=768068"
SRC_URI="mirror://gentoo/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.7"

RDEPEND="${DEPEND}"
