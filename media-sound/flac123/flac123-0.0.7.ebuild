# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/flac123/flac123-0.0.7.ebuild,v 1.5 2006/10/19 20:26:28 flameeyes Exp $

IUSE=""

DESCRIPTION="flac-tools provides flac123 a console app for playing FLAC audio files."
HOMEPAGE="http://flac-tools.sourceforge.net"
SRC_URI="mirror://sourceforge/flac-tools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc64 sparc x86"

DEPEND="~media-libs/flac-1.1.2
	media-libs/libao"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS NEWS README* TODO
}
