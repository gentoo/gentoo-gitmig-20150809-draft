# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zenity/zenity-2.14.2.ebuild,v 1.10 2006/10/20 20:49:55 kloeri Exp $

inherit gnome2

DESCRIPTION="Tool to display dialogs from the commandline and shell scripts"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	>=gnome-base/libgnomecanvas-2
	>=dev-libs/glib-2.7.3"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.29
	>=sys-devel/gettext-0.14
	>=dev-util/pkgconfig-0.9
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"


pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
}
