# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/khttrack/khttrack-0.10.ebuild,v 1.6 2004/04/29 09:31:03 dholm Exp $

inherit kde

DESCRIPTION="KDE 3.x frontend for httrack"
SRC_URI="http://savannah.nongnu.org/download/${PN}/stable.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.nongnu.org/${PN}/"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

need-kde 3

DEPEND=">=kde-base/kdelibs-3
	net-www/httrack"
RDEPEND=">=kde-base/kdelibs-3
		net-www/httrack"
