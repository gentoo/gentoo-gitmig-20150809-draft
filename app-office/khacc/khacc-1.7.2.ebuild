# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/khacc/khacc-1.7.2.ebuild,v 1.2 2004/05/01 17:22:44 centic Exp $

inherit kde
need-kde 3

newdepend ">=app-office/qhacc-2.9"

DESCRIPTION="KDE personal accounting system based on QHacc."
HOMEPAGE="http://qhacc.sourceforge.net"
SRC_URI="mirror://sourceforge/qhacc//${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

