# Copyright 2003 Sascha Rusch
# Distributed under the terms of the GNU General Public License v2
inherit kde-base || die

DESCRIPTION="KDE 3.x frontend for httrack"
SRC_URI="http://savannah.nongnu.org/download/${PN}/stable.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.nongnu.org/${PN}/"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

need-kde 3

DEPEND=">=kde-base/kdelibs-3
        net-www/httrack"
RDEPEND=">=kde-base/kdelibs-3
         net-www/httrack"

