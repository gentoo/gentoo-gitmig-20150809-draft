# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/contacts/contacts-0.12.ebuild,v 1.1 2010/09/13 21:10:53 eva Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit autotools eutils gnome2

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

src_prepare() {
	gnome2_src_prepare

	# Fix compilation with USE="-dbus", bug #247519, upstream bug #628614
	epatch "${FILESDIR}/${PN}-0.9-dbus.patch"

	# Fix compilation with gmake-3.82, bug #333647, upstream bug #628615
	epatch "${FILESDIR}/${PN}-0.11-fix-make-3.82.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}
