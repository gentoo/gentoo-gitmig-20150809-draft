# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/stock-quote/stock-quote-2.1.ebuild,v 1.3 2010/11/03 21:46:23 maekke Exp $

EAPI=2
inherit kde4-base

MY_P=plasma_${PN/-/_}-${PV}

DESCRIPTION="Displays stock quotes pulled from the Yahoo! servers"
HOMEPAGE="http://www.kde-look.org/content/show.php/Stock+Quote?content=90695"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/90695-${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"

S=${WORKDIR}/${MY_P}

DOCS="CHANGELOG README"
