# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kgamma/kgamma-0.9.1.ebuild,v 1.12 2002/12/09 04:41:52 manson Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="KGamma - a KControl modul for monitor gamma calibration"
SRC_URI="http://download.berlios.de/kgamma/${P}.tar.gz"
HOMEPAGE="http://kgamma.berlios.de/index2.php"
LICENSE="GPL-2"

KEYWORDS="x86 sparc "

