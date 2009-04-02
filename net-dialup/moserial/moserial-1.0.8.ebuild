# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/moserial/moserial-1.0.8.ebuild,v 1.1 2009/04/02 15:21:15 leio Exp $

EAPI=1
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="moserial is a clean, friendly gtk-based serial terminal"
HOMEPAGE="http://live.gnome.org/moserial"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.10:2
	gnome-base/gconf"
RDEPEND="${DEPEND}
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"
