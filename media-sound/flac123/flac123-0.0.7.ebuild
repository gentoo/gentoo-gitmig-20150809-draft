# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/flac123/flac123-0.0.7.ebuild,v 1.2 2004/11/03 16:48:07 corsair Exp $

IUSE=""

DESCRIPTION="flac-tools provides flac123 a console app for playing FLAC audio files."
SRC_URI="mirror://sourceforge/flac-tools/${P}.tar.gz"
HOMEPAGE="http://flac-tools.sourceforge.net"

KEYWORDS="~amd64 ~sparc ~x86 ~ppc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="media-libs/flac
	media-libs/libao"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS NEWS README* TODO
}
