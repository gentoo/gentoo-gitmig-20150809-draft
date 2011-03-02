# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gtk-g-rays2/gtk-g-rays2-1.20.ebuild,v 1.3 2011/03/02 21:28:54 jlec Exp $

EAPI="3"

inherit eutils gnome2 base

DESCRIPTION="GUI for accessing the Wintec WBT 201 / G-Rays 2 GPS device"
HOMEPAGE="http://www.daria.co.uk/gps"
SRC_URI="http://www.zen35309.zen.co.uk/gps/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	gnome-base/libglade:2.0
	x11-libs/cairo"
DEPEND="${DEPEND}
	dev-libs/libxslt
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	rm -rf debian/
	epatch "${FILESDIR}"/${P}-locale_h.patch
}

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	base_src_install
	dodoc README AUTHORS ChangeLog || die "dodoc failed"
}

pkg_postinst() { gnome2_icon_cache_update ; }
pkg_postrm() { gnome2_icon_cache_update ; }
