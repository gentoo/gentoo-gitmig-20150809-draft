# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/baghira/baghira-0.5h-r1.ebuild,v 1.6 2005/02/01 15:46:45 gustavoz Exp $

inherit kde eutils

DESCRIPTION="Baghira - an OS-X like style for KDE-3.2"
HOMEPAGE="http://baghira.sourceforge.net/"
SRC_URI="mirror://sourceforge/baghira/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc ~amd64 ~ppc ~alpha"
IUSE=""

DEPEND="|| ( kde-base/kdebase-meta >=kde-base/kdebase-3.2 )"
RDEPEND="|| ( kde-base/kdebase-meta >=kde-base/kdebase-3.2 )"
need-kde 3.2

src_unpack() {
	unpack ${A}
	cd ${S} && epatch ${FILESDIR}/baghira-ximian_fix.patch
}
