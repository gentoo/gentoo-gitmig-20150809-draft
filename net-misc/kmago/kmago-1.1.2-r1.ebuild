# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kmago/kmago-1.1.2-r1.ebuild,v 1.1 2001/10/03 22:20:18 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

DESCRIPTION="A Download Apllication for KDE2 based on wget"
SRC_URI="http://download.sourceforge.net/kmago/${P}.tar.gz"
HOMEPAGE="http://kmago.sourceforge.net"

DEPEND="$DEPEND >=kde-base/kdelibs-2.1.1"
RDEPEND="$RDEPEND >=kde-base/kdelibs-2.1.1"

