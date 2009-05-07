# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-fepg/vdr-fepg-0.4.0.ebuild,v 1.3 2009/05/07 21:06:05 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: show epg of multiple channels graphically"
HOMEPAGE="http://www.fepg.org/"
SRC_URI="http://www.fepg.org/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.36"
RDEPEND="${DEPEND}"