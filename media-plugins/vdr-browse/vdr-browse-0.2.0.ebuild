# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-browse/vdr-browse-0.2.0.ebuild,v 1.1 2008/02/25 10:38:00 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: browse now/next epg info while keep watching the current channel"
HOMEPAGE="http://www.fepg.org/"
SRC_URI="http://www.fepg.org/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.36"
RDEPEND="${DEPEND}"
