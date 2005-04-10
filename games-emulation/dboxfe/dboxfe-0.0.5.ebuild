# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dboxfe/dboxfe-0.0.5.ebuild,v 1.2 2005/04/10 12:42:33 blubb Exp $

inherit kde

DESCRIPTION="Creates and manages configuration files for DOSBox"
HOMEPAGE="http://chmaster.freeforge.net/dboxfe-project.htm"
SRC_URI="http://download.berlios.de/dboxfe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86 ~amd64"
IUSE=""

RDEPEND=">=games-emulation/dosbox-0.63"

need-kde 3.3
need-qt 3.3
