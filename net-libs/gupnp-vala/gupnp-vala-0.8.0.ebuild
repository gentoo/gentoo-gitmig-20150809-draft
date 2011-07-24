# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-vala/gupnp-vala-0.8.0.ebuild,v 1.1 2011/07/24 14:59:24 eva Exp $

EAPI=3

DESCRIPTION="Vala bindings for the GUPnP framework"
HOMEPAGE="http://gupnp.org/"
SRC_URI="http://gupnp.org/sites/all/files/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/vala-0.11.3:0.12[vapigen]
	>=net-libs/gupnp-0.13.3
	>=net-libs/gssdp-0.9.2
	>=net-libs/gupnp-ui-0.1.1
	>=net-libs/gupnp-av-0.7
	>=media-libs/gupnp-dlna-0.5.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		VALAC=$(type -p valac-0.12) \
		VAPIGEN=$(type -p vapigen-0.12)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
