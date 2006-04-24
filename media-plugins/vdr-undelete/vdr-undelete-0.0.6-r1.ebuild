# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-undelete/vdr-undelete-0.0.6-r1.ebuild,v 1.3 2006/04/24 20:36:59 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="VDR Plugin: Undelete of Recordings"
HOMEPAGE="http://www.fast-info.de/vdr/undelete/index.htm"
SRC_URI="http://www.fast-info.de/vdr/undelete/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="x86 ~amd64"

DEPEND=">=media-video/vdr-1.2.6"

PATCHES="${FILESDIR}/${P#vdr-}-info.diff"

