# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupnp-tools/gupnp-tools-0.7.ebuild,v 1.1 2008/10/28 21:46:16 tester Exp $

DESCRIPTION="Free replacements of Intel UPnP tools that use GUPnP."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://gupnp.org/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.12
	>=gnome-base/libglade-2.6
	>=x11-themes/gnome-icon-theme-2.20
	>=net-libs/gupnp-0.12
	>=net-libs/gupnp-av-0.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
