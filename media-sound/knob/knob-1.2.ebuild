# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/knob/knob-1.2.ebuild,v 1.6 2004/06/29 00:37:17 carlo Exp $

inherit kde

DESCRIPTION="Knob - The KDE Volume Control Applet"
HOMEPAGE="http://lichota.net/~krzysiek/projects/knob/"
SRC_URI="http://lichota.net/~krzysiek/projects/knob/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ~ppc"
IUSE=""

need-kde 3