# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/stock-quote/stock-quote-2.1.ebuild,v 1.4 2011/01/31 06:45:43 tampakrap Exp $

EAPI=3
inherit kde4-base

MY_P=plasma_${PN/-/_}-${PV}

DESCRIPTION="Displays stock quotes pulled from the Yahoo! servers"
HOMEPAGE="http://www.kde-look.org/content/show.php/Stock+Quote?content=90695"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/90695-${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
"
S=${WORKDIR}/${MY_P}

DOCS=( CHANGELOG README )
