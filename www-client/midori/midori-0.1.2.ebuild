# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-0.1.2.ebuild,v 1.1 2009/02/06 11:09:28 jokey Exp $

EAPI=2

inherit multilib gnome2-utils

DESCRIPTION="A lightweight web browser"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"
SRC_URI="http://goodies.xfce.org/releases/midori/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls soup sqlite"

DEPEND=">=dev-lang/python-2.4
	x11-libs/gtk+
	net-libs/webkit-gtk
	dev-libs/libxml2
	nls? ( sys-devel/gettext )
	soup? ( >=net-libs/libsoup-0.9 )
	sqlite? ( >=dev-db/sqlite-3.0 )"
RDEPEND="${DEPEND}"

src_configure() {
	./waf \
		--prefix="/usr/" \
		--libdir="/usr/$(get_libdir)" \
		configure || die "configure failed"
}

src_compile() {
	./waf build || die "build failed"
}

src_install() {
	DESTDIR=${D} ./waf install || die "install failed"
	dodoc AUTHORS ChangeLog INSTALL TODO
}

pkg_postinst() {
	gnome2_icon_cache_update
	ewarn "Midori tends to crash due to bugs in WebKit."
	ewarn "Report bugs at http://www.twotoasts.de/bugs"
}
