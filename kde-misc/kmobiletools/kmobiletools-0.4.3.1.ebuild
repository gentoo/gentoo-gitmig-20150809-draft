# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kmobiletools/kmobiletools-0.4.3.1.ebuild,v 1.1 2005/04/03 08:30:28 centic Exp $

inherit kde

DESCRIPTION="KMobiletools is a KDE-based application that allows to control mobile phones with your PC."
SRC_URI="http://download.berlios.de/kmobiletools/kmobiletools-${PV}.tar.bz2"
HOMEPAGE="http://kmobiletools.berlios.de/"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~x86 ~ppc"

need-kde 3.2
