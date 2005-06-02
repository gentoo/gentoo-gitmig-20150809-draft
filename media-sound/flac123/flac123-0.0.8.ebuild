# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/flac123/flac123-0.0.8.ebuild,v 1.4 2005/06/02 14:17:51 gustavoz Exp $

DESCRIPTION="flac-tools provides flac123 a console app for playing FLAC audio files."
HOMEPAGE="http://flac-tools.sourceforge.net"
SRC_URI="mirror://sourceforge/flac-tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc64 sparc x86 ~ppc"
IUSE=""

DEPEND="media-libs/flac
	media-libs/libao"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS NEWS README* TODO
}
