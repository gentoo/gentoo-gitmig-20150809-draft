# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/comix/comix-1.2.3.ebuild,v 1.1 2005/03/08 15:53:30 greg_g Exp $

inherit kde
KLV="16028"

DESCRIPTION="Comix style for KDE 3.3"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

need-kde 3.3
