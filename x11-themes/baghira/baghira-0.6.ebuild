# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/baghira/baghira-0.6.ebuild,v 1.2 2004/12/08 23:36:04 hansmi Exp $

inherit kde eutils

DESCRIPTION="Baghira - an OS-X like style for KDE-3.2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=8692"
SRC_URI="mirror://sourceforge/baghira/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~alpha"
IUSE=""

DEPEND=">=kde-base/kdebase-3.2"
RDEPEND=">=kde-base/kdebase-3.2"
need-kde 3.2

src_unpack() {
	unpack ${P}.tar.bz2

	if use ppc || use ppc64; then
		echo "#define HAVE_PPC 1" > ${P}/ppc.h
	fi
}

