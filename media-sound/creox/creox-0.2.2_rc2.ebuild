# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/creox/creox-0.2.2_rc2.ebuild,v 1.11 2006/05/31 11:07:42 flameeyes Exp $

ARTS_REQUIRED="yes"
inherit kde

MY_P=${P/_/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="CREOX Real Time Effects Processor"
HOMEPAGE="http://www.uid0.sk/zyzstar/?creox"
SRC_URI="http://www.uid0.sk/zyzstar/projects/creox/downloads/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64"
IUSE=""

DEPEND="media-sound/jack-audio-connection-kit"
need-kde 3

PATCHES="${FILESDIR}/${P}-ebusy.patch"
