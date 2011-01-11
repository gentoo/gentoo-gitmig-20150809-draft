# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-vala/gupnp-vala-0.6.12.ebuild,v 1.3 2011/01/11 05:50:06 ford_prefect Exp $

EAPI=2

DESCRIPTION="Vala bindings for the GUPnP framework"
HOMEPAGE="http://gupnp.org/"
SRC_URI="http://gupnp.org/sites/all/files/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/vala:0.10[vapigen]
	>=net-libs/gupnp-0.13.3
	>=net-libs/gssdp-0.7.2
	>=net-libs/gupnp-ui-0.1.1
	>=net-libs/gupnp-av-0.5.9
	>=media-libs/gupnp-dlna-0.3.0
	<media-libs/gupnp-dlna-0.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		VALAC=$(type -p valac-0.10) \
		VAPIGEN=$(type -p vapigen-0.10)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
