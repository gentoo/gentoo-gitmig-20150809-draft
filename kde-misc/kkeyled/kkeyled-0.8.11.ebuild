# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kkeyled/kkeyled-0.8.11.ebuild,v 1.1 2005/04/01 21:29:05 centic Exp $

inherit kde

need-kde 3

DESCRIPTION="KKeyLED - a Kicker module showing the status of your keyboard's numlock, capslock and scrolllock."
SRC_URI="http://www.truesoft.ch/dieter/kkeyled/software/${P}.tar.gz"
HOMEPAGE="http://www.truesoft.ch/dieter/kkeyled.html"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

S=${WORKDIR}/${PN}

