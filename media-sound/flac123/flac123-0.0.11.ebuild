# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/flac123/flac123-0.0.11.ebuild,v 1.1 2007/08/20 15:59:16 drac Exp $

DESCRIPTION="console app for playing FLAC audio files"
HOMEPAGE="http://flac-tools.sourceforge.net"
SRC_URI="mirror://sourceforge/flac-tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/flac
	media-libs/libao
	media-libs/libogg
	dev-libs/popt"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUGS ChangeLog NEWS README* TODO
}
