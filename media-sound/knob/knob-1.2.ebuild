# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/knob/knob-1.2.ebuild,v 1.4 2004/04/20 17:24:39 eradicator Exp $

IUSE=""

inherit kde-base
need-kde 3

DESCRIPTION="Knob - The KDE Volume Control Applet"
SRC_URI="http://lichota.net/~krzysiek/projects/knob/${P}.tar.gz"
HOMEPAGE="http://lichota.net/~krzysiek/projects/knob/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ~ppc"

