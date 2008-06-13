# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/eventwatcher/eventwatcher-0.4.3.ebuild,v 1.5 2008/06/13 20:01:22 flameeyes Exp $

inherit kde

DESCRIPTION="A KDE application which notifies about various events."
HOMEPAGE="http://eventwatcher.sourceforge.net/"
SRC_URI="mirror://sourceforge/eventwatcher/${P}.tar.bz2"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="|| ( kde-base/librss kde-base/kdenetwork )"

need-kde 3

PATCHES=(
	"${FILESDIR}/${P}-gcc4.patch"
)
