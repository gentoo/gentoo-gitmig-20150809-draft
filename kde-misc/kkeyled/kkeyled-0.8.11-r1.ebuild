# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kkeyled/kkeyled-0.8.11-r1.ebuild,v 1.1 2009/02/10 01:39:01 carlo Exp $


ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KKeyLED - a Kicker module showing the status of your keyboard's numlock, capslock and scrolllock."
HOMEPAGE="http://www.truesoft.ch/dieter/kkeyled.html"
SRC_URI="http://www.truesoft.ch/dieter/kkeyled/software/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${PN}"

need-kde 3.5

src_unpack() {
        kde_src_unpack
        rm "${S}"/configure
}