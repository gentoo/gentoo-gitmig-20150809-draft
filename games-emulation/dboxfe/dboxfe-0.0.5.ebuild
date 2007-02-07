# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dboxfe/dboxfe-0.0.5.ebuild,v 1.5 2007/02/07 13:47:54 nyhm Exp $

inherit kde

DESCRIPTION="Creates and manages configuration files for DOSBox"
HOMEPAGE="http://chmaster.freeforge.net/dboxfe-project.htm"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND=">=games-emulation/dosbox-0.63"

need-kde 3.3
need-qt 3.3
