# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-1.6.0.ebuild,v 1.1 2005/03/18 18:18:21 seemant Exp $

inherit gnome2 eutils

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND=">=net-www/epiphany-1.5.7
	>=dev-libs/libxml2-2.6
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	app-text/opensp
	>=net-www/mozilla-1.7"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.29"

#fixme adblock and find extensions don't compile
G2CONF="${G2CONF} --with-extensions=\
actions,\
bookmarks-tray,\
certificates,\
error-viewer,\
extensions-manager-ui,\
gestures,\
page-info,\
select-stylesheet,\
sidebar,\
smart-bookmarks,\
tab-groups,\
tabsmenu\
`use doc && echo ,sample-mozilla,sample`"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fix_includes.patch
	epatch ${FILESDIR}/${P}-disable_bookmarks-tray_label.patch
}

USE_DESTDIR="1"

DOCS="AUTHORS NEWS README"

