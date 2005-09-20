# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qinx/qinx-1.2.ebuild,v 1.6 2005/09/20 02:28:57 caleb Exp $

inherit kde eutils

DESCRIPTION="Qinx, a KDE style inspired by QNX Photon microGUI"
SRC_URI="http://www.usermode.org/code/${P}.tar.gz"
HOMEPAGE="http://www.usermode.org/code.html"

SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 ~alpha -ppc ~sparc ~amd64"
IUSE="arts"

DEPEND="|| ( kde-base/kdebase-meta kde-base/kdebase )"
RDEPEND="|| ( kde-base/kdebase-meta kde-base/kdebase )"
need-kde 3.2

src_unpack() {
	kde_src_unpack

	use arts || epatch ${FILESDIR}/${P}-configure-arts.patch
}
