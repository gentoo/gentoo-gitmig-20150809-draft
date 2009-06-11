# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kiosktool/kiosktool-1.0-r1.ebuild,v 1.4 2009/06/11 14:03:40 fauli Exp $

EAPI="2"

ARTS_REQUIRED="never"

USE_KEG_PACKAGING="1"

inherit kde

DESCRIPTION="KDE Kiosk GUI Admin Tool"
HOMEPAGE="http://extragear.kde.org/apps/kiosktool/"
SRC_URI="mirror://kde/stable/apps/KDE3.x/admin/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="3.5"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

need-kde 3.5
