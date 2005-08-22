# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-1.7.4-r1.ebuild,v 1.1 2005/08/22 00:32:01 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dbus debug firefox pcre python static"

RDEPEND=">=www-client/epiphany-1.7.3
	>=dev-libs/libxml2-2.6
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	app-text/opensp
	!firefox? ( >=www-client/mozilla-1.7.3 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	pcre? ( dev-libs/libpcre )
	dbus? ( >=sys-apps/dbus-0.22 )
	python? ( >=dev-lang/python-2.3 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.29"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog HACKING NEWS README"


pkg_setup() {
	G2CONF="$(use_enable static)"

	local extensions="actions bookmarks-tray certificates dashboard \
		error-viewer extensions-manager-ui gestures page-info sample \
		sample-mozilla select-stylesheet sidebar smart-bookmarks     \
		tab-groups tab-states tabsmenu"

	if use dbus && ! built_with_use www-client/epiphany dbus; then
		ewarn
		ewarn "To enable the extensions using dbus you neet to emerge"
		ewarn "www-client/epiphany with the 'dbus' USE flag enabled as well."
		ewarn
		ewarn "Skipping for now."
		ewarn
	else
		use dbus && extensions="${extensions} net-monitor rss"
	fi

	use pcre && extensions="${extensions} greasemonkey"
	# adblock causes segmentation faults. See bug #100618.

	use python && extensions="${extensions} python-console sample-python"

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

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-fix_includes.patch
}
