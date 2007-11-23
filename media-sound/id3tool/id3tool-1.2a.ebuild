# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3tool/id3tool-1.2a.ebuild,v 1.5 2007/11/23 21:28:16 corsair Exp $

DESCRIPTION="A command line utility for easy manipulation of the ID3 tags present in MPEG Layer 3 audio files"
HOMEPAGE="http://nekohako.xware.cx/id3tool"
SRC_URI="http://nekohako.xware.cx/id3tool/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc CHANGELOG README
}
