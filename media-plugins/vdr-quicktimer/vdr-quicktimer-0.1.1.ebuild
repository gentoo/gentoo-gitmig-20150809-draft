# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-quicktimer/vdr-quicktimer-0.1.1.ebuild,v 1.3 2007/07/10 23:09:00 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Fast generate timers with just entering Channel, Day and start time"
HOMEPAGE="http://users.tkk.fi/~phintuka/vdr/vdr-quicktimer/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.36"
