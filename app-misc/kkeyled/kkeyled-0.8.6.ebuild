# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kkeyled/kkeyled-0.8.6.ebuild,v 1.3 2004/03/14 10:59:03 mr_bones_ Exp $

inherit kde-base

need-kde 3

IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="KKeyLED - a Kicker module showing the status of your keyboard's numlock, capslock and scrolllock."
SRC_URI="http://www.truesoft.ch/dieter/kkeyled/software/${P}.tar.gz"
HOMEPAGE="http://www.truesoft.ch/dieter/kkeyled.html"
