# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/cervisia/cervisia-1.4.1.ebuild,v 1.2 2001/11/16 12:50:41 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2

DESCRIPTION="A CVS Client for KDE"
SRC_URI="http://prdownloads.sourceforge.net/cervisia/${P}.tar.gz"
HOMEPAGE="http://cervisia.sourceforge.net"




