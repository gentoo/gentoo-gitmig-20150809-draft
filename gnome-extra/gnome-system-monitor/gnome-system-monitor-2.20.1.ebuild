# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-2.20.1.ebuild,v 1.1 2007/10/17 20:02:02 eva Exp $

inherit gnome2

DESCRIPTION="The Gnome System Monitor"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="pcre"

RDEPEND=">=dev-libs/glib-2.9.1
	>=gnome-base/gconf-2
	>=x11-libs/libwnck-2.5
	>=gnome-base/libgtop-2.19.3
	>=x11-libs/gtk+-2.8
	>=gnome-base/gnome-vfs-2.6
	>=x11-themes/gnome-icon-theme-2.15.3
	pcre? ( >=dev-libs/libpcre-6.4 )
	>=dev-cpp/gtkmm-2.8
	dev-libs/libxml2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.35
	app-text/gnome-doc-utils"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable pcre pcrecpp) --disable-scrollkeeper"
}
