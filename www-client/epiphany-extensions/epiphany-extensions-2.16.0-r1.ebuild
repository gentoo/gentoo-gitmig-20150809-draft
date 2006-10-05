# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-2.16.0-r1.ebuild,v 1.1 2006/10/05 20:48:03 dang Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="debug pcre python"

RDEPEND=">=www-client/epiphany-2.16
	>=dev-libs/libxml2-2.6
	>=dev-libs/glib-2.8
	>=x11-libs/gtk+-2.8
	>=gnome-base/libglade-2
	app-text/opensp
	>=www-client/mozilla-firefox-1.0.2-r1
	pcre? ( >=dev-libs/libpcre-3.9-r2 )
	>=sys-apps/dbus-0.34
	python? ( >=dev-lang/python-2.3 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}/${P}-sessionsaver-v4.patch.gz"

	cp aclocal.m4 old_macros.m4
	AT_M4DIR=". ${S}/m4" WANT_AUTOCONF="2.5" \
	eautoreconf
}

pkg_setup() {
	local extensions="actions auto-reload auto-scroller certificates
	error-viewer extensions-manager-ui gestures java-console livehttpheaders
	page-info permissions push-scroller rss sample sample-mozilla
	select-stylesheet sessionsaver sidebar smart-bookmarks tab-groups
	tab-states"

	use pcre && extensions="${extensions} greasemonkey adblock"

	use python && extensions="${extensions} python-console sample-python \
		favicon"

	local list_exts=""
	for ext in $extensions; do
		[ "x${list_exts}" != "x" ] && list_exts="${list_exts},"
		list_exts="${list_exts}${ext}"
	done

	G2CONF="${G2CONF} --with-extensions=${list_exts} --with-mozilla=firefox"
}

