# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kmago/kmago-1.1.2-r1.ebuild,v 1.5 2002/07/01 21:33:31 danarmak Exp $

inherit kde-base || die

need-kde 2.1.1

LICENSE="GPL-2"
DESCRIPTION="A Download Apllication for KDE2 based on wget"
SRC_URI="http://download.sourceforge.net/kmago/${P}.tar.gz"
HOMEPAGE="http://kmago.sourceforge.net"


