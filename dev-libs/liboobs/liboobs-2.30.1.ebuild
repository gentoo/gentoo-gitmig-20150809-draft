# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liboobs/liboobs-2.30.1.ebuild,v 1.7 2011/01/31 16:57:55 armin76 Exp $

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Liboobs is a wrapping library to the System Tools Backends."
HOMEPAGE="http://www.gnome.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="doc"

# FIXME: check if policykit should be checked in configure ?

RDEPEND=">=dev-libs/glib-2.14
	>=dev-libs/dbus-glib-0.70
	>=app-admin/system-tools-backends-2.9.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1.9 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --with-hal=no --disable-static"
}
