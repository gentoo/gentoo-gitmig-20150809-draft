# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rppppoek/rppppoek-0.33.ebuild,v 1.2 2003/07/13 11:36:51 aliz Exp $

inherit kde-base
need-kde 3

IUSE=""
DESCRIPTION="KDE panel applet for managing (TM)RP-PPPoE"
SRC_URI="http://download.berlios.de/segfaultskde/${P}.tar.gz"
HOMEPAGE="http://segfaultskde.berlios.de/index.php?content=rppppoek"

LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="${RDEPEND} net-dialup/rp-pppoe
	app-admin/sudo"

PATCHES="${FILESDIR}/${P}-panelicon.patch"
