# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-avards/vdr-avards-0.1.1.ebuild,v 1.1 2007/12/02 17:13:56 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin:  Automatic Video Aspect Ratio Detection and Signaling"
HOMEPAGE="http://www.vdr-portal.de/board/thread.php?threadid=66358"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.44"
