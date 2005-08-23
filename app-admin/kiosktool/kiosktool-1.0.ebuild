# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kiosktool/kiosktool-1.0.ebuild,v 1.5 2005/08/23 21:56:34 greg_g Exp $

inherit kde

DESCRIPTION="KDE Kiosk GUI Admin Tool"
HOMEPAGE="http://extragear.kde.org/apps/kiosktool/"
SRC_URI="mirror://kde/stable/apps/KDE3.x/admin/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

need-kde 3.2
