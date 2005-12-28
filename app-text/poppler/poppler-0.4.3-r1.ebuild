# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler/poppler-0.4.3-r1.ebuild,v 1.2 2005/12/28 19:04:03 dang Exp $

inherit eutils autotools

DESCRIPTION="Poppler is a PDF rendering library based on the xpdf-3.0 code base."
HOMEPAGE="http://poppler.freedesktop.org"
SRC_URI="http://poppler.freedesktop.org/${P}.tar.gz
	mirror://${P}-utils.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="gtk jpeg qt zlib cairo"

RDEPEND=">=media-libs/freetype-2.1.8
	media-libs/fontconfig
	virtual/ghostscript
	cairo? ( >=x11-libs/cairo-0.5 )
	gtk? ( >=x11-libs/gtk+-2.4 )
	qt? ( =x11-libs/qt-3* )
	jpeg? ( >=media-libs/jpeg-6b )
	zlib? ( sys-libs/zlib )
	!<app-text/xpdf-3.01-r4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/automake-1.9.6"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/poppler-0.4.1-cairo-ft.patch
	epatch ${DISTDIR}/poppler-0.4.3-utils.patch.gz
	eautoreconf
}

src_compile() {
	econf --disable-poppler-qt4 --enable-opi \
		$(use_enable cairo cairo-output) \
		$(use_enable jpeg libjpeg) \
		$(use_enable zlib) \
		$(use_enable gtk poppler-glib) \
		$(use_enable qt poppler-qt) \
		|| die "configuration failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog NEWS README-XPDF TODO
}
