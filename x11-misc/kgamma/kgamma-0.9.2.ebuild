# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.11 2001/12/06 22:12:34 drobbins Exp
inherit kde-base

need-kde 3

DESCRIPTION="KGamma - a KControl modul for monitor gamma calibration"
SRC_URI="http://download.berlios.de/kgamma/${P}.tar.gz"
HOMEPAGE="http://kgamma.berlios.de/index2.php"
LICENSE="GPL-2"

KEYWORDS="x86"

#myconf="$myconf --enable-final"
