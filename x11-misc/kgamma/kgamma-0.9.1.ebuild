# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Michael v.Ostheim <MvOstheim@web.de>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.11 2001/12/06 22:12:34 drobbins Exp

inherit kde-base || die

need-kde 3

DESCRIPTION="KGamma - a KControl modul for monitor gamma calibration"
SRC_URI="http://ftp.kde.com/Utilities/X_Window_System/KGamma/${P}.tar.gz"
HOMEPAGE="http://www.vonostheim.de/kgamma/index2.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

#myconf="$myconf --enable-final"
