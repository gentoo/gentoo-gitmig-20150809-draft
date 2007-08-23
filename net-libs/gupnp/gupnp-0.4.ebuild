# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp/gupnp-0.4.ebuild,v 1.1 2007/08/23 15:31:21 drac Exp $

DESCRIPTION="an object-oriented framework for creating UPnP devs and control points."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://${PN}.org/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=net-libs/gssdp-0.4
	>=net-libs/libsoup-2.2
	dev-libs/libxml2
	x11-misc/shared-mime-info
	sys-fs/e2fsprogs"
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
	dodoc AUTHORS ChangeLog NEWS README
	use doc || rm -rf "${D}"/usr/share/gtk-doc/html/${PN}
}
