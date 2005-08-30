# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler/poppler-0.4.1.ebuild,v 1.1 2005/08/30 03:42:21 dang Exp $

inherit eutils

DESCRIPTION="Poppler is a PDF rendering library based on the xpdf-3.0 code base."
HOMEPAGE="http://poppler.freedesktop.org"
SRC_URI="http://poppler.freedesktop.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~mips"
IUSE="gtk qt"

# cairo is in packages.mask

DEPEND=">=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3
	media-libs/fontconfig
	virtual/ghostscript
	dev-util/pkgconfig
	gtk? ( =x11-libs/gtk+-2* )
	qt? ( =x11-libs/qt-3* )"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-cairo-ft.patch
	autoconf || die "autoconf failed"
	automake || die "automake failed"
	libtoolize --force || die "libtoolize failed"
}

src_compile() {
	use qt || myconf="--disable-poppler-qt"

	econf $(use_enable qt poppler-qt) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog NEWS README-XPDF TODO
}
