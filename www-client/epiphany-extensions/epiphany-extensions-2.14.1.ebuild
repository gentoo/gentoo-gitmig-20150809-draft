# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-2.14.1.ebuild,v 1.1 2006/05/01 21:11:08 dang Exp $

inherit eutils gnome2

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dbus debug firefox pcre python"

RDEPEND=">=www-client/epiphany-2.14.0
	>=dev-libs/libxml2-2.6
	>=dev-libs/glib-2.8
	>=x11-libs/gtk+-2.8
	>=gnome-base/libglade-2
	app-text/opensp
	!firefox? ( >=www-client/mozilla-1.7.5 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	pcre? ( >=dev-libs/libpcre-3.9-r2 )
	dbus? ( >=sys-apps/dbus-0.34 )
	python? ( >=dev-lang/python-2.3 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	local extensions="actions auto-reload auto-scroller certificates \
		dashboard error-viewer extensions-manager-ui gestures page-info \
		push-scroller sample sample-mozilla select-stylesheet sidebar smart-bookmarks \
		tab-groups tab-states tabsmenu"

	if use dbus && ! built_with_use www-client/epiphany dbus; then
		ewarn
		ewarn "To enable the extensions using dbus you neet to emerge"
		ewarn "www-client/epiphany with the 'dbus' USE flag enabled as well."
		ewarn
		ewarn "Skipping for now."
		ewarn
	else
		use dbus && extensions="${extensions} rss"
	fi

	use pcre && extensions="${extensions} greasemonkey adblock"

	use python && extensions="${extensions} python-console sample-python \
		favicon"

	local list_exts=""
	for ext in $extensions; do
		[ "x${list_exts}" != "x" ] && list_exts="${list_exts},"
		list_exts="${list_exts}${ext}"
	done

	G2CONF="${G2CONF} --with-extensions=${list_exts}"

	if use firefox; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=mozilla"
	fi
}

