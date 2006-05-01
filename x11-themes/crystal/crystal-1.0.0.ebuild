# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/crystal/crystal-1.0.0.ebuild,v 1.1 2006/05/01 15:59:56 voxus Exp $

inherit kde

DESCRIPTION="KDE native window decoration with transparent titlebar, buttons and borders"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=13969"
SRC_URI="http://www.kde-look.org/content/files/13969-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

DEPEND="|| ( kde-base/kwin kde-base/kdebase )"

need-kde 3.2
