# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/liquid/liquid-0.9.7.ebuild,v 1.14 2008/12/07 13:30:06 jmbsvicetto Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="Liquid theme, revamped for KDE 3.2"
HOMEPAGE="http://developer.berlios.de/projects/liquid/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2
		mirror://gentoo/kde-admindir-3.5.3.tar.bz2"
LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| ( =kde-base/kwin-3.5* =kde-base/kdebase-3.5* )"

need-kde 3.2
