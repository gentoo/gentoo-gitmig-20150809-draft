# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/kvisualboyadvance/kvisualboyadvance-0.3.1.ebuild,v 1.7 2004/11/11 01:46:26 josejx Exp $

inherit kde

DESCRIPTION="A front end for VisualBoyAdvance for KDE"
HOMEPAGE="http://kvisualboyadvance.openlindows.com/"
SRC_URI="http://kvisualboyadvance.openlindows.com/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND="games-emulation/visualboyadvance"
need-kde 3.2
