# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kooldock/kooldock-0.4.6.ebuild,v 1.1 2007/03/31 17:58:02 carlo Exp $

inherit kde

IUSE=""

DESCRIPTION=" KoolDock is a dock for KDE with cool visual enhancements and effects"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=50910"
SRC_URI="mirror://sourceforge/kooldock/${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

SLOT="0"

need-kde 3.5
