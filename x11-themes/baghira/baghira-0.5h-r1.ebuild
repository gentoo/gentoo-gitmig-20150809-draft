# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/baghira/baghira-0.5h-r1.ebuild,v 1.3 2004/11/28 21:59:42 centic Exp $

inherit kde eutils

DESCRIPTION="Baghira - an OS-X like style for KDE-3.2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=8692"
SRC_URI="mirror://sourceforge/baghira/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~sparc ~amd64 ~ppc ~alpha"
IUSE=""

DEPEND=">=kde-base/kdebase-3.2"
RDEPEND=">=kde-base/kdebase-3.2"
need-kde 3.2

src_unpack() {
	unpack ${A}
	cd ${S} && epatch ${FILESDIR}/baghira-ximian_fix.patch
}
