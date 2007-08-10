# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-2.18.2.ebuild,v 1.4 2007/08/10 13:24:11 angelos Exp $

WANT_AUTOMAKE="1.9"
inherit eutils gnome2 autotools

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~hppa ppc sparc ~x86"
IUSE="debug pcre python xulrunner"

RDEPEND=">=www-client/epiphany-2.18
	gnome-base/gconf
	>=dev-libs/libxml2-2.6
	>=dev-libs/glib-2.12
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2
	app-text/opensp
	!xulrunner? ( >=www-client/mozilla-firefox-1.5 )
	xulrunner? ( net-libs/xulrunner )
	pcre? ( >=dev-libs/libpcre-3.9-r2 )
	>=dev-libs/dbus-glib-0.71
	python? ( >=dev-lang/python-2.3 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${PN}-2.18.0-sessionsaver-v4.patch.gz

	cp aclocal.m4 old_macros.m4
	AT_M4DIR=". ${S}/m4" eautoreconf
}

pkg_setup() {
	local extensions="actions auto-reload auto-scroller certificates
	error-viewer extensions-manager-ui gestures java-console
	livehttpheaders page-info permissions push-scroller rss
	select-stylesheet sessionsaver sidebar smart-bookmarks tab-groups
	tab-states"

	use pcre && extensions="${extensions} greasemonkey adblock"

	use python && extensions="${extensions} python-console favicon
		cc-license-viewer epilicious"

	local list_exts=""
	for ext in $extensions; do
		[ "x${list_exts}" != "x" ] && list_exts="${list_exts},"
		list_exts="${list_exts}${ext}"
	done

	G2CONF="${G2CONF} --with-extensions=${list_exts}"
	if use xulrunner; then
		G2CONF="${G2CONF} --with-gecko=xulrunner"
	else
		G2CONF="${G2CONF} --with-gecko=firefox"
	fi
}
