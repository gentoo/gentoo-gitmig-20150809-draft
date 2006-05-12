# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/osalp/osalp-0.7.3.ebuild,v 1.9 2006/05/12 23:01:52 tcort Exp $

IUSE="encode vorbis"

DESCRIPTION="Open Source Audio Library Project"
HOMEPAGE="http://osalp.sourceforge.net/"
LICENSE="GPL-2"

DEPEND="encode? ( >=media-sound/lame-1.89 )
	vorbis? ( >=media-libs/libvorbis-1.0 )"

SLOT="0"
KEYWORDS="x86"
SRC_URI="mirror://sourceforge/osalp/${P}.tar.gz"

src_compile() {
	local myconf
	use encode && myconf="--enable-lame"
	use vorbis && myconf="${myconf} --enable-ogg"
	./configure \
		${myconf} \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS README TODO NEWS
}
