# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xzgv/xzgv-0.7-r1.ebuild,v 1.9 2004/07/14 18:34:44 agriffis Exp $

DESCRIPTION="An X image viewer."
SRC_URI="http://xzgv.browser.org/${P}.tar.gz"
HOMEPAGE="http://xzgv.browser.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	sys-libs/zlib
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.0"

src_unpack() {
	unpack ${A}

	cd ${S}
	cp config.mk config.mk.orig
	sed -e "s:-O2 -Wall:${CFLAGS}:" \
		config.mk.orig > config.mk
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin /usr/share/info /usr/share/man/man1
	make PREFIX=${D}/usr \
		 SHARE_INFIX=/share \
		 INFO_DIR_UPDATE=no \
		 MANDIR=${D}/usr/share/man/man1 \
	     install || die

	# Fix info files
	cd ${D}/usr/share/info
	for i in 1 2 3
	do
		mv xzgv-$i.gz xzgv.info-$i.gz
	done
	gzip -dc xzgv.gz | \
		sed -e 's:^xzgv-:xzgv\.info-:g' | \
		gzip -9c > xzgv.info.gz
	rm xzgv.gz

	cd ${S}

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO
}
