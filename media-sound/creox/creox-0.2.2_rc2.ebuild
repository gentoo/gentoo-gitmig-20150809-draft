# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/creox/creox-0.2.2_rc2.ebuild,v 1.3 2004/05/06 16:27:22 eradicator Exp $

inherit kde

IUSE=""

MY_P=${P/_/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="CREOX Real Time Effects Processor"
HOMEPAGE="http://www.uid0.sk/zyzstar/?creox"
SRC_URI="http://www.uid0.sk/zyzstar/projects/creox/downloads/${MY_P}.tar.bz2"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

need-kde 3

DEPEND="virtual/jack"
