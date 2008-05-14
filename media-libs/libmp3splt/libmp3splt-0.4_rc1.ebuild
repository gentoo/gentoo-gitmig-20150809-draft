# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmp3splt/libmp3splt-0.4_rc1.ebuild,v 1.3 2008/05/14 16:03:25 corsair Exp $

DESCRIPTION="a library for mp3splt to split mp3 and ogg files without decoding."
HOMEPAGE="http://mp3splt.sourceforge.net"
SRC_URI="mirror://sourceforge/mp3splt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/libmad
	media-libs/libvorbis
	media-libs/libid3tag"
DEPEND="${RDEPEND}"

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog LIMITS NEWS README TODO
}
