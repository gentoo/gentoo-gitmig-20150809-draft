# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kdirstat/kdirstat-2.4.0.ebuild,v 1.7 2004/06/30 13:12:29 agriffis Exp $

inherit kde eutils

DESCRIPTION="KDirStat - nice KDE replacement to du command"
HOMEPAGE="http://kdirstat.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdirstat/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ~sparc ~amd64"

IUSE=""
SLOT="0"

need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}/kdirstat/
	epatch ${FILESDIR}/kdirstatapp.h.fix.patch
}
