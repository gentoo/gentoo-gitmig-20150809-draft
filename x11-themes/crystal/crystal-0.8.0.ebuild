# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/crystal/crystal-0.8.0.ebuild,v 1.2 2004/10/28 11:55:02 voxus Exp $

inherit kde
need-kde 3.2
KLV="13969"

DESCRIPTION="KDE native window decoration with transparent titlebar, buttons and borders"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""
