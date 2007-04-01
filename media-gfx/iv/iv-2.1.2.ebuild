# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iv/iv-2.1.2.ebuild,v 1.2 2007/04/01 23:01:34 vanquirius Exp $

inherit eutils

DESCRIPTION="A basic image viewer for GTK+-1.2"
HOMEPAGE="http://wolfpack.twu.net/IV/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="gif imlib jpeg png xpm"

DEPEND="=x11-libs/gtk+-1.2*
	gif? ( >=media-libs/giflib-4.1.0-r3 )
	imlib? ( >=media-libs/imlib-1.9.13 )
	jpeg? ( >=media-libs/jpeg-6b )
	png? ( >=media-libs/libpng-1.2 )"

src_compile() {
	./configure Linux --prefix=/usr \
		--disable="arch-i486" \
		--disable="arch-i586" \
		--disable="arch-i686" \
		--disable="arch-pentiumpro" \
		$(use_enable gif libgif) \
		$(use_enable imlib Imlib) \
		$(use_enable imlib Imlib-transpixel-fix) \
		$(use_enable jpeg libjpeg) \
		$(use_enable png libpng) \
		$(use_enable xpm libxpm) \
		--CFLAGS="${CFLAGS}" \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make install \
		PREFIX="${D}"/usr \
		MAN_DIR="${D}"/usr/share/man/man1 \
		|| die "make install failed"

	dodoc README

	# eog.desktop uses name Image Viewer, so differentiate
	make_desktop_entry iv "IV Image Viewer" /usr/share/icons/iv.xpm "Graphics;Viewer"
}
