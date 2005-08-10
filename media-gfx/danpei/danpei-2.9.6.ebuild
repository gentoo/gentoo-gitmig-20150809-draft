# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/danpei/danpei-2.9.6.ebuild,v 1.3 2005/08/10 09:55:46 metalgod Exp $

DESCRIPTION="GTK1-based Image and Thumbnail viewer, explorer style."
HOMEPAGE="http://danpei.sourceforge.net/"
SRC_URI="mirror://sourceforge/danpei/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/libpng-1.0.3
	>=media-libs/gdk-pixbuf-0.8.0
	>=media-gfx/imagemagick-4.2.2"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install
	insinto /usr/share/pixmaps
	doins src/icon/danpei.xpm
	insinto /usr/share/applications
	doins ${FILESDIR}/danpei.desktop

	dodoc AUTHORS ChangeLog* FAQ INSTALL* NEWS README* TODO*
}
