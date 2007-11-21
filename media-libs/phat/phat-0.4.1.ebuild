# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phat/phat-0.4.1.ebuild,v 1.6 2007/11/21 17:13:10 nixnut Exp $

DESCRIPTION="PHAT is a collection of GTK+ widgets geared toward pro-audio apps."
HOMEPAGE="http://phat.berlios.de"
SRC_URI="http://download2.berlios.de/${PN}/${P}.tar.gz
	http://download.berlios.de/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="debug doc"

RDEPEND=">=x11-libs/gtk+-2.4
	gnome-base/libgnomecanvas"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	sed -e "s:-Werror::g" -e "s:-O3:${CFLAGS}:g" -i "${S}"/configure
}

src_compile() {
	econf $(use_enable debug)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
	use doc || rm -rf "${D}"/usr/share/gtk-doc/html/${PN}
}
