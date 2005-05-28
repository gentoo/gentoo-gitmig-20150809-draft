# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt/mp3splt-2.1.ebuild,v 1.4 2005/05/28 12:06:02 luckyduck Exp $

DESCRIPTION="A command line utility to split mp3 and ogg files"
HOMEPAGE="http://mp3splt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mp3splt/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa -mips ~ppc ~sparc ~x86"
IUSE="ogg"

DEPEND="ogg? ( media-libs/libogg
	media-libs/libvorbis )
	media-libs/libmad"

src_compile() {
	local myconf

	# --enable-ogg doesn't enable ogg...
	use ogg || myconf="--disable-ogg"
	econf ${myconf} || die "econf failed"

	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
