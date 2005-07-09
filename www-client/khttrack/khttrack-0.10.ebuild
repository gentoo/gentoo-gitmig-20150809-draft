# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/khttrack/khttrack-0.10.ebuild,v 1.3 2005/07/09 04:49:17 agriffis Exp $

inherit kde eutils

DESCRIPTION="KDE 3.x frontend for httrack"
SRC_URI="http://savannah.nongnu.org/download/khttrack/stable.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.nongnu.org/khttrack/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~amd64"
IUSE="arts"

DEPEND="www-client/httrack"
RDEPEND="www-client/httrack"
need-kde 3

src_unpack() {
	kde_src_unpack

	use arts || epatch ${FILESDIR}/khttrack-0.10-configure-arts.patch
}
