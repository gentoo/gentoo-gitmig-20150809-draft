# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdirstat/kdirstat-2.5.3-r1.ebuild,v 1.1 2008/09/14 23:08:50 carlo Exp $

ARTS_REQUIRED="never"

inherit kde eutils

DESCRIPTION="KDirStat - nice KDE replacement to du command"
HOMEPAGE="http://kdirstat.sourceforge.net/"
SRC_URI="http://kdirstat.sourceforge.net/download/${P}.tar.bz2"
#SRC_URI="mirror://sourceforge/kdirstat/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""
SLOT="0"

PATCHES=( "${FILESDIR}/${P}-gcc43.patch"
		"${FILESDIR}/kdirstat-2.5.3-desktop-entry-fix.diff" )
need-kde 3.5

src_unpack() {
	kde_src_unpack
	rm configure
}
