# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cervisia/cervisia-1.4.1.ebuild,v 1.14 2003/07/22 20:11:11 vapier Exp $

inherit kde-base

need-kde 2

DESCRIPTION="A CVS Client for KDE"
SRC_URI="mirror://sourceforge/cervisia/${P}.tar.gz"
HOMEPAGE="http://cervisia.sourceforge.net"


LICENSE="QPL-1.0"
KEYWORDS="x86 sparc "

# NOTE: the KDE 3 version of cervisia is part of the kdesdk module, 
# emerge that instead
