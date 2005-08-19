# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-1.7.4.ebuild,v 1.1 2005/08/19 20:19:22 joem Exp $

inherit eutils gnome2

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="debug firefox static"

RDEPEND=">=www-client/epiphany-1.7.4
	>=dev-libs/libxml2-2.6
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	app-text/opensp
	!firefox? ( >=www-client/mozilla-1.7.3 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	dev-libs/libpcre
	>=sys-apps/dbus-0.22"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-fix_includes.patch
}

USE_DESTDIR="1"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

src_compile() {
	local extensions="actions adblock bookmarks-tray certificates dashboard
	error-viewer extensions-manager-ui gestures greasemonkey page-info sample
	sample-mozilla rss select-stylesheet sidebar python-console smart-bookmarks
	tab-groups tab-states tabsmenu"

	# The find extension doesn't compile against mozilla
	#use firefox && extensions="${extensions} find"

	if built_with_use www-client/epiphany dbus; then
		extensions="${extensions} net-monitor"
	else
		ewarn
		ewarn "In order to install the net-monitor extension, you need to"
		ewarn "emerge www-client/epiphany with the 'dbus' USE flag enabled."
		ewarn
		ewarn "Skipping for now."
		ewarn
	fi

	local list_exts=""
	for ext in $extensions; do
		[ "x${list_exts}" != "x" ] && list_exts="${list_exts},"
		list_exts="${list_exts}${ext}"
	done

	G2CONF="${G2CONF} $(use_enable static) --with-extensions=${list_exts}"

	if use firefox; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=mozilla"
	fi

	gnome2_src_compile
}
