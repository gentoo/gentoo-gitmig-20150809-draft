# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/osalp/osalp-0.7.3.ebuild,v 1.1 2002/08/21 01:37:30 agenkin Exp $

DESCRIPTION="Open Source Audio Library Project"
HOMEPAGE="http://osalp.sourceforge.net/"
LICENSE="GPL"

DEPEND="encode? ( >=media-sound/lame-1.89 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

SLOT="0"
KEYWORDS="x86"
SRC_URI="mirror://sourceforge/osalp/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	local myconf
	use encode && myconf="--enable-lame"
	use oggvorbis && myconf="${myconf} --enable-ogg"
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
	dodoc AUTHORS COPYING COPYING.LIB INSTALL README TODO NEWS
}
