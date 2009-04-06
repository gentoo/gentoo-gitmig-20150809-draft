# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-0.1.5.ebuild,v 1.3 2009/04/06 17:21:13 mr_bones_ Exp $

EAPI=2

inherit multilib gnome2-utils

DESCRIPTION="A lightweight web browser"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"
SRC_URI="http://goodies.xfce.org/releases/midori/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="soup sqlite"

RDEPEND=">=dev-lang/python-2.4
	>=net-libs/webkit-gtk-0_p42000
	soup? ( >=net-libs/libsoup-0.9 )
	sqlite? ( >=dev-db/sqlite-3.0 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

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
