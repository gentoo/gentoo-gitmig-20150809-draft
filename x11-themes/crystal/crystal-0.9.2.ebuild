# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/crystal/crystal-0.9.2.ebuild,v 1.4 2005/08/03 19:15:26 gustavoz Exp $

inherit kde
KLV="13969"

DESCRIPTION="KDE native window decoration with transparent titlebar, buttons and borders"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64 ~sparc"
IUSE=""

DEPEND="|| ( kde-base/kwin kde-base/kdebase )"

need-kde 3.2
