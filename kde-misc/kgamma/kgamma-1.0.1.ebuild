# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgamma/kgamma-1.0.1.ebuild,v 1.3 2005/01/14 23:10:34 danarmak Exp $

inherit kde

DESCRIPTION="KGamma - a KControl modul for monitor gamma calibration"
SRC_URI="http://download.berlios.de/kgamma/${P}.tar.bz2"
HOMEPAGE="http://kgamma.berlios.de/index2.php"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="!>=kde-base/kdelibs-3.3 !kde-base/kgamma !>=kde-base/kdegraphics-3.4.0_alpha1"
need-kde 3