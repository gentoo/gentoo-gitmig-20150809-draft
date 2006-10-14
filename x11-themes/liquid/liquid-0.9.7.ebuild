# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/liquid/liquid-0.9.7.ebuild,v 1.10 2006/10/14 11:28:21 flameeyes Exp $

inherit kde

ARTS_REQUIRED="never"

DESCRIPTION="Liquid theme, revamped for KDE 3.2"
HOMEPAGE="http://developer.berlios.de/projects/liquid/"
SRC_URI="http://download.berlios.de/liquid/${P}.tar.bz2
		mirror://gentoo/kde-admindir-3.5.3.tar.bz2"
LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| ( kde-base/kwin >=kde-base/kdebase-3.2 )"

need-kde 3.2
