# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/crystal/crystal-0.7.5.ebuild,v 1.2 2004/08/28 22:27:10 dholm Exp $

inherit kde

DESCRIPTION="KDE native window decoration with transparent titlebar, buttons and borders"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=13969"
SRC_URI="http://www.kde-look.org/content/files/13969-crystal-0.7.5.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=kde-base/kdebase-3.2"
RDEPEND=">=kde-base/kdebase-3.2"
need-kde 3.2
