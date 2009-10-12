# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kkeyled/kkeyled-0.8.11.ebuild,v 1.6 2009/10/12 07:30:37 abcd Exp $

inherit kde

need-kde 3

DESCRIPTION="KKeyLED - a Kicker module showing the status of your keyboard's numlock, capslock and scrolllock."
SRC_URI="http://www.truesoft.ch/dieter/kkeyled/software/${P}.tar.gz"
HOMEPAGE="http://www.truesoft.ch/dieter/kkeyled.html"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc x86"

S=${WORKDIR}/${PN}
