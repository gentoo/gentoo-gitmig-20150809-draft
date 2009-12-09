# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-vala/gupnp-vala-0.6.2.ebuild,v 1.1 2009/12/09 04:14:07 ford_prefect Exp $

EAPI=2

DESCRIPTION="Vala bindings for the GUPnP framework"
HOMEPAGE="http://gupnp.org/"
SRC_URI="http://gupnp.org/sources/bindings/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/vala-0.7.8[vapigen]
	>=net-libs/gupnp-0.13
	>=net-libs/gssdp-0.7
	>=net-libs/gupnp-ui-0.1.1
	>=net-libs/gupnp-av-0.5.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
