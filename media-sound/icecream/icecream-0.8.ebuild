# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/media-sound/icecream-0.8, 2004/04/13 10:11:00

IUSE=""

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://icecream.sourceforge.net/"
SRC_URI="mirror://sourceforge/icecream/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="dev-lang/perl"

src_install() {
	dodoc COPYING
	mv icecream.man icecream.1 && doman icecream.1
	dobin icecream
}
