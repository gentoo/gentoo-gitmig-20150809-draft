# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-igd/gupnp-igd-0.1.3.ebuild,v 1.11 2010/02/12 18:38:50 josejx Exp $

EAPI=2

DESCRIPTION="This is a library to handle UPnP IGD port mapping for GUPnP."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://gupnp.org/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=net-libs/gupnp-0.12.3
	=net-libs/gupnp-0.12*
	>=dev-libs/glib-2.16:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

# See bug 277956. Remove from next ebuild, when gupnp-0.13 support is available.
RESTRICT="test"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-gtk-doc
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README TODO
}
