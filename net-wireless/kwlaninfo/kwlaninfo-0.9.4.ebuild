# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kwlaninfo/kwlaninfo-0.9.4.ebuild,v 1.2 2006/03/25 05:25:21 mr_bones_ Exp $

inherit kde

RDEPEND="net-wireless/wireless-tools"

DESCRIPTION="KDE Applet to display information about wlan connections"
HOMEPAGE="http://www.ph-home.de/opensource/kde3/kwlaninfo/"
SRC_URI="http://www.ph-home.de/opensource/kde3/kwlaninfo/${P}.tgz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

need-kde 3.0
