# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/kmago/kmago-1.1.2-r1.ebuild,v 1.10 2002/08/14 12:08:08 murphy Exp $

inherit kde-base || die

need-kde 2.1.1

LICENSE="GPL-2"
DESCRIPTION="A Download Apllication for KDE2 based on wget"
SRC_URI="http://download.sourceforge.net/kmago/${P}.tar.gz"
HOMEPAGE="http://kmago.sourceforge.net"
KEYWORDS="x86 sparc sparc64"


