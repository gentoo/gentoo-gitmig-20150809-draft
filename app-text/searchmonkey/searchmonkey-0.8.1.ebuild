# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/searchmonkey/searchmonkey-0.8.1.ebuild,v 1.1 2007/02/06 22:35:39 armin76 Exp $

inherit eutils

DESCRIPTION="Powerful text searches using regular expressions"
HOMEPAGE="http://searchmonkey.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	make_desktop_entry ${PN} ${PN} ${PN}.png "Utility;GTK"
}
