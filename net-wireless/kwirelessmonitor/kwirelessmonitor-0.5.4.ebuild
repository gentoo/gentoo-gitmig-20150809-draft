# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kwirelessmonitor/kwirelessmonitor-0.5.4.ebuild,v 1.3 2005/01/06 19:23:49 sekretarz Exp $

inherit kde

DESCRIPTION="KWirelessMonitor is a small KDE application that docks into the system tray and monitors the wireless network interface."
HOMEPAGE="http://www-2.cs.cmu.edu/~pach/kwirelessmonitor/"
SRC_URI="http://www-2.cs.cmu.edu/~pach/kwirelessmonitor/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

RDEPEND="${DEPEND}
	net-wireless/wireless-tools"

need-kde 3.2
