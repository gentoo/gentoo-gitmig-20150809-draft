# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kmobiletools/kmobiletools-0.4.1.ebuild,v 1.1 2005/01/02 17:01:34 motaboy Exp $

inherit kde

DESCRIPTION="KMobiletools is a KDE-based application that allows to control mobile phones with your PC."
SRC_URI="http://download.berlios.de/kmobiletools/kmobiletools-${PV}.tar.bz2"
HOMEPAGE="http://kmobiletools.berlios.de"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~x86"

need-kde 3.2
