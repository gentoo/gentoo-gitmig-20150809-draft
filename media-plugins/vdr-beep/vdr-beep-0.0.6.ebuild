# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-beep/vdr-beep-0.0.6.ebuild,v 1.4 2011/01/28 17:28:03 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Use the PC speaker to signalize some events (shutdown, cut done etc.)"
HOMEPAGE="http://deltab.de/vdr/beep.html"
SRC_URI="http://deltab.de/vdr/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.36"
