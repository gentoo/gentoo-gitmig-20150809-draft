# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/khttrack/khttrack-0.10.ebuild,v 1.9 2004/08/03 19:40:08 centic Exp $

inherit kde

DESCRIPTION="KDE 3.x frontend for httrack"
SRC_URI="http://savannah.nongnu.org/download/khttrack/stable.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.nongnu.org/khttrack/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="net-www/httrack"
RDEPEND="net-www/httrack"
need-kde 3
