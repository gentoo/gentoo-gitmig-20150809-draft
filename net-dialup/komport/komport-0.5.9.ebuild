# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/komport/komport-0.5.9.ebuild,v 1.1 2004/06/01 19:59:07 carlo Exp $

IUSE=""

inherit kde

need-kde 3

DESCRIPTION="Komport - Serial port communications and vt102 terminal emulator for KDE"
SRC_URI="mirror://sourceforge/komport/${P}.tar.gz"
HOMEPAGE="http://komport.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86"
