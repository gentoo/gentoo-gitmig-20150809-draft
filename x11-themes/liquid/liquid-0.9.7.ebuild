# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/liquid/liquid-0.9.7.ebuild,v 1.3 2005/01/15 00:22:34 danarmak Exp $

inherit kde

DESCRIPTION="Liquid theme, revamped for KDE 3.2"
HOMEPAGE="http://developer.berlios.de/projects/liquid/"
SRC_URI="http://download.berlios.de/liquid/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"
IUSE=""

DEPEND="|| ( kde-base/kdebase-meta >=kde-base/kdebase-3.2* )"
RDEPEND="|| ( kde-base/kdebase-meta >=kde-base/kdebase-3.2* )"
need-kde 3.2
