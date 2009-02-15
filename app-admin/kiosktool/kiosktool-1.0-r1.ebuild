# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kiosktool/kiosktool-1.0-r1.ebuild,v 1.1 2009/02/15 22:23:30 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KDE Kiosk GUI Admin Tool"
HOMEPAGE="http://extragear.kde.org/apps/kiosktool/"
SRC_URI="mirror://kde/stable/apps/KDE3.x/admin/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

need-kde 3.5
