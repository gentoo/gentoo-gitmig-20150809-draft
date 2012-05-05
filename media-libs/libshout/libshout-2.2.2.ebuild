# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-2.2.2.ebuild,v 1.2 2012/05/05 08:02:31 jdhore Exp $

inherit eutils autotools

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

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-automagic.patch"
	epatch "${FILESDIR}/${P}-asneeded.patch"
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf $(use_enable theora)\
		$(use_enable speex)\
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README examples/example.c
	rm -rf "${D}"/usr/share/doc/libshout
}
