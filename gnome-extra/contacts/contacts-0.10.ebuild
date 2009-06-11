# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/contacts/contacts-0.10.ebuild,v 1.1 2009/06/11 21:31:43 eva Exp $

GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A small, lightweight addressbook for GNOME"
HOMEPAGE="http://pimlico-project.org/contacts.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus"

RDEPEND=">=gnome-extra/evolution-data-server-1.8
	>=x11-libs/gtk+-2.6"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35.0
	>=dev-util/pkgconfig-0.9"

# README is empty
DOCS="AUTHORS ChangeLog NEWS"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable dbus)"
}

src_unpack() {
	gnome2_src_unpack

	# Fix compilation with USE="-dbus", bug #247519
	epatch "${FILESDIR}/${PN}-0.9-dbus.patch"
}
