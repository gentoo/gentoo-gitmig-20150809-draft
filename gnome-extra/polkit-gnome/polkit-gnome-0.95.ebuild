# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/polkit-gnome/polkit-gnome-0.95.ebuild,v 1.2 2009/12/25 17:57:43 nirbheek Exp $

EAPI="2"

inherit eutils gnome2

DESCRIPTION="PolicyKit policies and configurations for the GNOME desktop"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples" #introspection

RDEPEND=">=x11-libs/gtk+-2.17.1
	>=gnome-base/gconf-2.8
	>=dev-libs/dbus-glib-0.71
	>=sys-auth/polkit-0.95"
	# Not ready for tree
	#introspection? ( >=dev-libs/gobject-introspection-0.6.2 )
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35.0
	>=app-text/scrollkeeper-0.3.14
	doc? ( >=dev-util/gtk-doc-1.3 )"

DOCS="AUTHORS HACKING NEWS TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-introspection
		$(use_enable examples)"
		#$(use_enable introspection)"
}

src_prepare() {
	# Fix make check, bug 298345
	epatch "${FILESDIR}/${P}-fix-make-check.patch"
}
