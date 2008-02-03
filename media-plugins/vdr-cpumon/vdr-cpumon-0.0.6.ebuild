# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-cpumon/vdr-cpumon-0.0.6.ebuild,v 1.1 2008/02/03 18:23:55 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Show cpu-usage on OSD"
HOMEPAGE="http://www.christianglass.de/cpumon/"
SRC_URI="http://www.christianglass.de/cpumon//${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.44"
