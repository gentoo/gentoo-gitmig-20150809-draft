# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gssdp/gssdp-0.4.ebuild,v 1.1 2007/08/23 15:28:39 drac Exp $

DESCRIPTION="A GObject-based API for handling resource discovery and announcement over SSDP."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://gupnp.org/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc minimal"

RDEPEND=">=dev-libs/glib-2.9.1
	>=net-libs/libsoup-2.2.97
	!minimal? ( >=gnome-base/libglade-2.6 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( dev-util/gtk-doc )"

src_compile() {
	econf $(use_with doc gtk-doc) $(use_with !minimal libglade)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
	use doc || rm -rf "${D}"/usr/share/gtk-doc/html/${PN}
}
