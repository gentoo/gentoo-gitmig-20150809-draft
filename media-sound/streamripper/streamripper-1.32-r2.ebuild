# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.32-r2.ebuild,v 1.6 2004/07/01 08:00:10 eradicator Exp $

inherit eutils

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net/"
SRC_URI="http://streamripper.sourceforge.net/files/${P}.tar.gz
	mirror://gentoo/${P}-interface.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${P}-interface.patch
	epatch ${FILESDIR}/${PV}-http-auth.patch
}

src_install() {
	dobin streamripper || die
	dodoc CHANGES README THANKS TODO
}
