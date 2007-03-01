# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kooldock/kooldock-0.4.5.ebuild,v 1.1 2007/03/01 01:28:08 troll Exp $

inherit kde

IUSE=""

DESCRIPTION=" KoolDock is a dock for KDE with cool visual enhancements and effects"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=50910"
# kde-apps link is broken for us - no version in filename... my mirror instead:
SRC_URI="http://vivid.dat.pl/kde/${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

SLOT="0"

need-kde 3.2
