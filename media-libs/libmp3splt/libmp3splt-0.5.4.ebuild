# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmp3splt/libmp3splt-0.5.4.ebuild,v 1.1 2009/04/30 00:26:13 ssuominen Exp $

EAPI=2

DESCRIPTION="a library for mp3splt to split mp3 and ogg files without decoding."
HOMEPAGE="http://mp3splt.sourceforge.net"
SRC_URI="mirror://sourceforge/mp3splt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/libmad
	media-libs/libvorbis
	media-libs/libogg
	media-libs/libid3tag"
DEPEND="${RDEPEND}
	sys-apps/findutils"

src_configure() {
	econf --disable-dependency-tracking --disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog LIMITS NEWS README TODO
	find "${D}"/usr -name '*.la' -delete
}
