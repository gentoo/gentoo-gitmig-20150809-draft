# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler/poppler-0.1.2.ebuild,v 1.2 2005/03/14 19:35:25 lanius Exp $

DESCRIPTION="Poppler is a PDF rendering library based on the xpdf-3.0 code base."
HOMEPAGE="http://poppler.freedesktop.org"
SRC_URI="http://poppler.freedesktop.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~mips"
IUSE="gtk"

DEPEND=">=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3
	virtual/ghostscript
	dev-util/pkgconfig
	gtk? ( =x11-libs/gtk+-2* )"

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog NEWS README-XPDF TODO
}
