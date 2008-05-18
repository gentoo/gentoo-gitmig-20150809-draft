# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/cssed/cssed-0.4.0-r1.ebuild,v 1.4 2008/05/18 16:09:44 drac Exp $

DESCRIPTION="CSSED a GTK2 application to help create and maintain CSS style sheets for web developing"
HOMEPAGE="http://cssed.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="plugins"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/atk-1.4.0
	>=dev-libs/glib-2.2.3
	>=media-libs/fontconfig-2.2.0-r2
	>=x11-libs/pango-1.2.1-r1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_with plugins plugin-headers) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
}
