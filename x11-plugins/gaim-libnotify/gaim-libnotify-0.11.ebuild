# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-libnotify/gaim-libnotify-0.11.ebuild,v 1.2 2006/08/08 13:35:13 metalgod Exp $

DESCRIPTION="gaim-libnotify provides popups for gaim via a libnotify interface"
HOMEPAGE="http://gaim-libnotify.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls debug"

DEPEND=">=x11-libs/libnotify-0.3.2"

RDEPEND=">=net-im/gaim-1.9.99"

src_compile() {
	local myconf

	myconf="$(use_enable debug) \
			$(use_enable nls)"

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO VERSION
}
