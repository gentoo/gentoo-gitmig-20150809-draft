# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/icecream/icecream-0.8.ebuild,v 1.2 2004/09/16 20:21:24 eradicator Exp $

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
