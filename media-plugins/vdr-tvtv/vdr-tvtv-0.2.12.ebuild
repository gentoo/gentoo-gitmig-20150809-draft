# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-tvtv/vdr-tvtv-0.2.12.ebuild,v 1.1 2006/03/17 06:49:11 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: create record-timer from the website of the TVTV service"
HOMEPAGE="http://www.isis.de/~mgross/"
SRC_URI="http://www.isis.de/~mgross/tvtv/${P}.tgz"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"

