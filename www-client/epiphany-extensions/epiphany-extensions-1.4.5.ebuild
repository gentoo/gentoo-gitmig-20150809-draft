# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-1.4.5.ebuild,v 1.3 2005/03/23 16:19:48 seemant Exp $

inherit gnome2

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=www-client/epiphany-1.4.6
	>=dev-libs/libxml2-2.6
	>=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2
	app-text/opensp
	>=www-client/mozilla-1.7"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} --with-extensions=\
certificates,\
error-viewer,\
gestures,\
page-info,\
select-stylesheet,\
sidebar,\
smart-bookmarks,\
tab-groups,\
tabsmenu"

USE_DESTDIR="1"

DOCS="AUTHORS NEWS README"

