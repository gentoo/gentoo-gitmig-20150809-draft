# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kgamma/kgamma-0.9.2.ebuild,v 1.4 2002/10/27 11:17:33 danarmak Exp $
inherit kde-base

need-kde 3

DESCRIPTION="KGamma - a KControl modul for monitor gamma calibration"
SRC_URI="http://download.berlios.de/kgamma/${P}.tar.gz"
HOMEPAGE="http://kgamma.berlios.de/index2.php"
LICENSE="GPL-2"

KEYWORDS="x86"

#set_enable_final
