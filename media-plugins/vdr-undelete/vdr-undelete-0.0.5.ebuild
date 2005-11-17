# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-undelete/vdr-undelete-0.0.5.ebuild,v 1.1 2005/11/17 22:05:34 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Undelete of Recordings"
HOMEPAGE="http://www.fast-info.de/vdr/undelete/index.htm"
SRC_URI="http://www.fast-info.de/vdr/undelete/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.3.22"
