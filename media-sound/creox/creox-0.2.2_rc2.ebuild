# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/creox/creox-0.2.2_rc2.ebuild,v 1.5 2004/06/15 22:45:44 eradicator Exp $

inherit kde eutils

IUSE=""

MY_P=${P/_/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="CREOX Real Time Effects Processor"
HOMEPAGE="http://www.uid0.sk/zyzstar/?creox"
SRC_URI="http://www.uid0.sk/zyzstar/projects/creox/downloads/${MY_P}.tar.bz2"

KEYWORDS="x86 ~ppc ~amd64"
LICENSE="GPL-2"

need-kde 3

DEPEND="media-sound/jack-audio-connection-kit"

src_unpack() {
	kde_src_unpack

	cd ${S}
	epatch ${FILESDIR}/${P}-ebusy.patch
}
