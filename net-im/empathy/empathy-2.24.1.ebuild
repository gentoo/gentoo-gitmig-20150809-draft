# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/empathy/empathy-2.24.1.ebuild,v 1.4 2009/01/07 17:17:43 armin76 Exp $

inherit gnome2

DESCRIPTION="Telepathy client and library using GTK+"
HOMEPAGE="http://live.gnome.org/Empathy"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE="applet python spell test"

RDEPEND=">=dev-libs/dbus-glib-0.51
	>=dev-libs/glib-2.16.0
	>=x11-libs/gtk+-2.12.0
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	applet? ( >=gnome-base/gnome-panel-2.10 )
	>=net-libs/telepathy-glib-0.7.7
	>=net-im/telepathy-mission-control-4.61
	dev-libs/libxml2
	>=gnome-extra/evolution-data-server-1.2
	spell? (
		app-text/enchant
		app-text/iso-codes )
	python? (
		>=dev-lang/python-2.4.4-r5
		>=dev-python/pygtk-2 )"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	>=dev-util/intltool-0.35.0
	>=dev-util/pkgconfig-0.16
	test? ( >=dev-libs/check-0.9.4 )
	dev-libs/libxslt
	virtual/python"

DOCS="CONTRIBUTORS AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="$(use_enable debug)
		$(use_enable spell)
		$(use_enable python)
		$(use_enable applet megaphone)
		$(use_enable applet nothere)
		--disable-gtk-doc"
}

src_unpack() {
	gnome2_src_unpack

	# Remove hard enabled -Werror (see AM_MAINTAINER_MODE), bug 218687
	sed -i "s:-Werror::g" configure || die "sed failed"
}

pkg_postinst() {
	gnome2_pkg_postinst
	echo
	elog "Empathy needs telepathy's connection managers to use any IM protocol."
	elog "You will need to install connection managers yourself."
	elog "MSN: net-voip/telepathy-butterfly"
	elog "Jabber and Gtalk: net-voip/telepathy-gabble"
	elog "IRC: net-irc/telepathy-idle"
	elog
	elog "Additionally, you will need >=net-voip/telepathy-stream-engine-0.5.0"
	elog "if you want any voip functionality."
}
