# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/khacc/khacc-1.7.2.ebuild,v 1.1 2003/10/10 13:44:52 caleb Exp $
inherit kde

need-kde 3

newdepend ">=app-office/qhacc-2.9"

DESCRIPTION="KDE personal accounting system based on QHacc."
HOMEPAGE="http://qhacc.sourceforge.net"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/qhacc//${P}.tar.gz"
KEYWORDS="~x86"

