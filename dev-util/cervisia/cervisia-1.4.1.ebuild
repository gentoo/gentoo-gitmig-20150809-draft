# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/cervisia/cervisia-1.4.1.ebuild,v 1.1 2001/10/03 22:20:18 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

DESCRIPTION="A CVS Client for KDE"
SRC_URI="http://prdownloads.sourceforge.net/cervisia/${P}.tar.gz"
HOMEPAGE="http://cervisia.sourceforge.net"

DEPEND="$DEPEND >=kde-base/kdelibs-2.0"
RDEPEND="$RDEPEND >=kde-base/kdelibs-2.0"




