# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rppppoek/rppppoek-0.33.ebuild,v 1.5 2004/11/20 10:23:19 mrness Exp $

inherit kde

DESCRIPTION="KDE panel applet for managing (TM)RP-PPPoE"
HOMEPAGE="http://segfaultskde.berlios.de/index.php?content=rppppoek"
SRC_URI="http://download.berlios.de/segfaultskde/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

RDEPEND="net-dialup/rp-pppoe
	app-admin/sudo
	sys-apps/grep
	sys-apps/net-tools"
need-kde 3

PATCHES="${FILESDIR}/${P}-panelicon.patch"
