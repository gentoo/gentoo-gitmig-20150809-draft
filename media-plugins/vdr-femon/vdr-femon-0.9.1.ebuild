# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-femon/vdr-femon-0.9.1.ebuild,v 1.1 2005/08/07 13:56:46 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: DVB Frontend Status Monitor (signal strengt/noise)"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/femon/"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/femon/files/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.3.21"
