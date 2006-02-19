# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rppppoek/rppppoek-0.40.ebuild,v 1.1 2006/02/19 08:31:08 mrness Exp $

inherit kde

DESCRIPTION="KDE panel applet for managing RP-PPPoE (tm)"
HOMEPAGE="http://segfaultskde.berlios.de/index.php?content=rppppoek"
SRC_URI="http://segfaultskde.berlios.de/rppppoek/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-dialup/rp-pppoe
	app-admin/sudo"
need-kde 3
