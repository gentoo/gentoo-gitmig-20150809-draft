# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp/gupnp-0.12.8.ebuild,v 1.1 2009/06/18 07:36:21 ssuominen Exp $

EAPI=2

DESCRIPTION="an object-oriented framework for creating UPnP devs and control points."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://${PN}.org/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-libs/gssdp-0.6
	net-libs/libsoup:2.4
	>=dev-libs/glib-2.18:2
	dev-libs/libxml2
	sys-fs/e2fsprogs"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		--disable-gtk-doc-html \
		--disable-gtk-doc-pdf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
