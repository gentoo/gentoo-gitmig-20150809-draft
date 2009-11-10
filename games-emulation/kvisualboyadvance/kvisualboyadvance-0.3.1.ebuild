# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/kvisualboyadvance/kvisualboyadvance-0.3.1.ebuild,v 1.9 2009/11/10 21:17:13 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="A front end for VisualBoyAdvance for KDE"
HOMEPAGE="http://kvisualboyadvance.openlindows.com/"
SRC_URI="http://kvisualboyadvance.openlindows.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="games-emulation/visualboyadvance"

need-kde 3.5
