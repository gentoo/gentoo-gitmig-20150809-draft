# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-svdrposd/vdr-svdrposd-0.1.0.ebuild,v 1.1 2009/10/08 08:30:17 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin to export OSD via TCP to vdr-remoteosd"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/svdrpext/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0
	!media-plugins/vdr-svdrpext"
RDEPEND="${DEPEND}"
