# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-igd/gupnp-igd-0.1.7.ebuild,v 1.6 2010/09/23 16:08:09 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="This is a library to handle UPnP IGD port mapping for GUPnP."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://www.gupnp.org/sites/all/files/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE="python"

RDEPEND=">=net-libs/gupnp-0.13.2
	>=dev-libs/glib-2.16:2
	python? ( >=dev-python/pygobject-2.16 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/gtk-doc-am"

src_prepare() {
	epatch "${FILESDIR}"/${P}-make-382.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		$(use_enable python) \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README TODO
}
