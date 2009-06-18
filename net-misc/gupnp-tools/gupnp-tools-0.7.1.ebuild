# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupnp-tools/gupnp-tools-0.7.1.ebuild,v 1.1 2009/06/18 08:40:43 ssuominen Exp $

EAPI=2

DESCRIPTION="Free replacements of Intel UPnP tools that use GUPnP."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://gupnp.org/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.16:2
	>=gnome-base/libglade-2.6
	>=x11-themes/gnome-icon-theme-2.20
	>=net-libs/gupnp-0.12
	>=net-libs/gupnp-av-0.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
