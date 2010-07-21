# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-av/gupnp-av-0.5.7.ebuild,v 1.1 2010/07/21 10:51:29 ford_prefect Exp $

EAPI=2

DESCRIPTION="a small utility library that aims to ease the handling UPnP A/V profiles."
HOMEPAGE="http://gupnp.org/"
SRC_URI="http://gupnp.org/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.16:2
	>=net-libs/gupnp-0.13[introspection?]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
	    $(use_enable introspection) \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		--disable-gtk-doc-html \
		--disable-gtk-doc-pdf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
