# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/comix/comix-1.3.6.ebuild,v 1.1 2006/03/07 10:19:59 flameeyes Exp $

inherit kde
KLV="16028"

DESCRIPTION="Comix style for KDE"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/kwin >=kde-base/kdebase-3.3 )"

need-kde 3.3
