# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/khttrack/khttrack-0.10.ebuild,v 1.12 2005/02/27 22:59:54 weeve Exp $

inherit kde eutils

DESCRIPTION="KDE 3.x frontend for httrack"
SRC_URI="http://savannah.nongnu.org/download/khttrack/stable.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.nongnu.org/khttrack/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"
IUSE=""

DEPEND="net-www/httrack"
RDEPEND="net-www/httrack"
need-kde 3

src_unpack() {
	kde_src_unpack

	use arts || epatch ${FILESDIR}/khttrack-0.10-configure-arts.patch
}
