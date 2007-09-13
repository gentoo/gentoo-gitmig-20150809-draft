# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-ui/gupnp-ui-0.1.ebuild,v 1.1 2007/09/13 14:50:55 drac Exp $

DESCRIPTION="Collection of simple GTK+ widgets on top of GUPnP."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://gupnp.org/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2
	>=net-libs/gupnp-0.3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( dev-util/gtk-doc )"

src_compile() {
	econf $(use_enable doc gtk-doc)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README
	use doc || rm -rf "${D}"/usr/share/gtk-doc/html/${PN}
}
