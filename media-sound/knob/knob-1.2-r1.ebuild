# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/knob/knob-1.2-r1.ebuild,v 1.3 2004/09/03 09:59:36 eradicator Exp $

inherit kde eutils

DESCRIPTION="Knob - The KDE Volume Control Applet"
HOMEPAGE="http://lichota.net/~krzysiek/projects/knob/"
SRC_URI="http://lichota.net/~krzysiek/projects/knob/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~alpha ~ppc amd64"
IUSE=""

need-kde 3

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-fPIC.patch
}
