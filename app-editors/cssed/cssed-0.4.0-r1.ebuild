# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/cssed/cssed-0.4.0-r1.ebuild,v 1.2 2008/01/23 10:12:16 wrobel Exp $

DESCRIPTION="CSSED a GTK2 application to help create and maintain CSS style sheets for web developing"
HOMEPAGE="http://cssed.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="plugin"
DEPEND=">=x11-libs/gtk+-2
		dev-util/pkgconfig
		>=dev-libs/atk-1.4.0
		>=dev-libs/glib-2.2.3
		>=media-libs/fontconfig-2.2.0-r2
		>=x11-libs/pango-1.2.1-r1"

src_compile() {
	econf $(use_with plugin plugin-headers) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
}
