# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kgamma/kgamma-0.9.1.ebuild,v 1.13 2003/02/13 17:15:27 vapier Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="KGamma - a KControl modul for monitor gamma calibration"
SRC_URI="http://download.berlios.de/kgamma/${P}.tar.gz"
HOMEPAGE="http://kgamma.berlios.de/index2.php"
LICENSE="GPL-2"

KEYWORDS="x86 sparc "

