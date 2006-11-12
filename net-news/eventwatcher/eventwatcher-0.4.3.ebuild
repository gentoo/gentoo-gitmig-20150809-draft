# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/eventwatcher/eventwatcher-0.4.3.ebuild,v 1.4 2006/11/12 22:08:54 troll Exp $

inherit kde

DESCRIPTION="A KDE application which notifies about various events."
HOMEPAGE="http://eventwatcher.sourceforge.net/"
SRC_URI="mirror://sourceforge/eventwatcher/${P}.tar.bz2"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="|| ( kde-base/librss kde-base/kdenetwork )"

need-kde 3

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc4.patch
}
