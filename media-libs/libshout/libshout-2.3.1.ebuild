# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-2.3.1.ebuild,v 1.1 2012/06/22 16:14:17 aballier Exp $

EAPI=4

DESCRIPTION="library for connecting and sending data to icecast servers"
HOMEPAGE="http://www.icecast.org/"
SRC_URI="http://downloads.xiph.org/releases/libshout/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="speex theora"

RDEPEND="media-libs/libogg
	media-libs/libvorbis
	theora? ( media-libs/libtheora )
	speex? ( media-libs/speex )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf $(use_enable theora)\
		$(use_enable speex)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README examples/example.c
	rm -rf "${D}"/usr/share/doc/libshout || die
}
