# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/cervisia/cervisia-1.4.1.ebuild,v 1.9 2002/07/27 10:44:30 seemant Exp $

inherit kde-base || die

need-kde 2

DESCRIPTION="A CVS Client for KDE"
SRC_URI="mirror://sourceforge/cervisia/${P}.tar.gz"
HOMEPAGE="http://cervisia.sourceforge.net"


LICENSE="QPL-1.0"
KEYWORDS="x86"

# NOTE: the KDE 3 version of cervisia is part of the kdesdk module, 
# emerge that instead
