# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3tool/id3tool-1.2.ebuild,v 1.10 2005/07/25 12:38:31 dholm Exp $

IUSE=""

DESCRIPTION="A command line utility for easy manipulation of the ID3 tags present in MPEG Layer 3 audio files"
HOMEPAGE="http://nekohako.xware.cx/id3tool/"
SRC_URI="http://nekohako.xware.cx/id3tool/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
DEPEND=""

src_install() {
	einstall
	dodoc CHANGELOG COPYING README
}
