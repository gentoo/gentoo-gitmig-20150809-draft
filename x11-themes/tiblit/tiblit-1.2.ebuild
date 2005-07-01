# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tiblit/tiblit-1.2.ebuild,v 1.2 2005/07/01 09:00:40 voxus Exp $

inherit kde
need-kde 3.2
KLV="20798"

DESCRIPTION="KDE style  focused on customization"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
