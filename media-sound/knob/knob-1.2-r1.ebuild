# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/knob/knob-1.2-r1.ebuild,v 1.7 2009/06/01 17:45:33 ssuominen Exp $

ARTS_REQUIRED=yes
inherit kde

DESCRIPTION="Knob - The KDE Volume Control Applet"
HOMEPAGE="http://lichota.net/~krzysiek/projects/knob/"
SRC_URI="http://lichota.net/~krzysiek/projects/knob/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha ~ppc amd64"
IUSE=""

need-kde 3

PATCHES=( "${FILESDIR}/${P}-fPIC.patch" )
