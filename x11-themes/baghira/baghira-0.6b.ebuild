# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/baghira/baghira-0.6b.ebuild,v 1.1 2005/02/14 14:23:31 centic Exp $

inherit kde

DESCRIPTION="Baghira - an OS-X like style for KDE"
HOMEPAGE="http://baghira.sourceforge.net/"
SRC_URI="mirror://sourceforge/baghira/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~alpha"
IUSE=""

DEPEND="|| ( kde-base/kdebase-meta >=kde-base/kdebase-3.3 )"
need-kde 3.3

src_unpack() {
	unpack ${A}
	# small deco patch for 0.6b
	epatch ${FILESDIR}/${P}-3.3.patch || die
}
