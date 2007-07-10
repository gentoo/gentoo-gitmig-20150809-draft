# Copyright 2003-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-launcher/vdr-launcher-0.0.2a-r1.ebuild,v 1.2 2007/07/10 23:08:59 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: launch other plugins - even when their menu-entry is hidden"
HOMEPAGE="http://people.freenet.de/cwieninger/html/vdr-launcher.html"
SRC_URI="http://people.freenet.de/cwieninger/${P/vdr/vdr_1.3.11}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.7"
