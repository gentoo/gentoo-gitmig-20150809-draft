# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.32-r1.ebuild,v 1.4 2004/04/01 08:24:41 eradicator Exp $

inherit eutils

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net/"
SRC_URI="http://streamripper.sourceforge.net/files/${P}.tar.gz
	mirror://gentoo/${P}-interface.patch.bz2
	http://wh0rd.de/gentoo/distfiles/${P}-interface.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	epatch ${P}-interface.patch
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin streamripper
	dodoc CHANGES README THANKS TODO
}
