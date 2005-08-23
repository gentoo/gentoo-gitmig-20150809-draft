# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kbandwidth/kbandwidth-1.0.3.ebuild,v 1.2 2005/08/23 22:27:56 greg_g Exp $

inherit kde
need-kde 3

DESCRIPTION="Network monitoring Kicker-applet for KDE 3.x"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=18939"
SRC_URI="http://people.freenet.de/stealth/kbandwidth/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"
IUSE=""

S=${WORKDIR}/${PN}
