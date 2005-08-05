# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/comix/comix-1.3.4.ebuild,v 1.1 2005/08/05 11:33:18 greg_g Exp $

inherit kde
KLV="16028"

DESCRIPTION="Comix style for KDE"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/kwin >=kde-base/kdebase-3.3 )"

need-kde 3.3
