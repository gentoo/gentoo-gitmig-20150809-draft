# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-2.16.1-r1.ebuild,v 1.4 2006/12/17 00:43:03 dertobi123 Exp $

inherit eutils gnome2

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~hppa ppc ~sparc x86"
IUSE="debug pcre python"

RDEPEND=">=www-client/epiphany-2.16
	>=dev-libs/libxml2-2.6
	>=dev-libs/glib-2.12
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2
	app-text/opensp
	>=www-client/mozilla-firefox-1.0.2-r1
	pcre? ( >=dev-libs/libpcre-3.9-r2 )
	|| ( >=dev-libs/dbus-glib-0.71
		( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.34 ) )
	python? ( >=dev-lang/python-2.3 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	local extensions="actions auto-reload auto-scroller certificates
	error-viewer extensions-manager-ui gestures java-console
	livehttpheaders page-info permissions push-scroller rss
	select-stylesheet sidebar smart-bookmarks tab-groups tab-states"

	use pcre && extensions="${extensions} greasemonkey adblock"

	use python && extensions="${extensions} python-console favicon"

	local list_exts=""
	for ext in $extensions; do
		[ "x${list_exts}" != "x" ] && list_exts="${list_exts},"
		list_exts="${list_exts}${ext}"
	done

	G2CONF="${G2CONF} --with-extensions=${list_exts} --with-mozilla=firefox"
}

