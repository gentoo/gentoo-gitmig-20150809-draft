# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/icecream/icecream-0.8.ebuild,v 1.5 2004/11/22 05:26:01 eradicator Exp $

IUSE=""

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://icecream.sourceforge.net/"
SRC_URI="mirror://sourceforge/icecream/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND="dev-lang/perl"

src_install() {
	newman icecream.man icecream.1
	dobin icecream
}
