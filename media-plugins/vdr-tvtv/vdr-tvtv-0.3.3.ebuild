# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-tvtv/vdr-tvtv-0.3.3.ebuild,v 1.3 2007/07/10 23:09:00 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: create record-timer from the website of the TVTV service"
HOMEPAGE="http://home.arcor.de/grossmar"
SRC_URI="http://home.arcor.de/grossmar/tvtv/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6
	net-misc/curl"
