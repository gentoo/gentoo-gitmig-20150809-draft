# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ezstream/ezstream-0.4.0.ebuild,v 1.1 2007/03/31 12:03:02 aballier Exp $

DESCRIPTION="Enables you to stream mp3 or vorbis files to an icecast server without reencoding"
HOMEPAGE="http://www.icecast.org/ezstream.php"
SRC_URI="http://downloads.xiph.org/releases/ezstream/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="taglib"

DEPEND="media-libs/libvorbis
	media-libs/libogg
	>=media-libs/libshout-2.1
	media-libs/libtheora
	dev-libs/libxml2
	taglib? ( media-libs/taglib )"
RDEPEND="${DEPEND}
	net-misc/icecast"

src_compile() {
	#we'll take care of these with dodoc
	sed -i -e "s/COPYING NEWS README//" Makefile.in
	sed -i -e "s/examples//" Makefile.in

	econf $(use_with taglib) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README NEWS
	docinto examples
	dodoc examples/ezstream*
	dodoc examples/*sh
}
