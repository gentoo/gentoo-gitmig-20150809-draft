# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/knob/knob-1.2-r1.ebuild,v 1.6 2006/05/31 11:05:50 flameeyes Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="Knob - The KDE Volume Control Applet"
HOMEPAGE="http://lichota.net/~krzysiek/projects/knob/"
SRC_URI="http://lichota.net/~krzysiek/projects/knob/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ~ppc amd64"
IUSE=""

need-kde 3

PATCHES="${FILESDIR}/${P}-fPIC.patch"
