# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mergeant/mergeant-0.66.ebuild,v 1.3 2011/03/21 21:07:03 nirbheek Exp $

EAPI="2"
#WANT_AUTOCONF="2.5"
#WANT_AUTOMAKE="1.9"

inherit gnome2

DESCRIPTION="Front-end for database administrators and developers"
HOMEPAGE="http://www.gnome-db.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE="debug doc"

RDEPEND=">=gnome-extra/libgnomedb-2.99.6:3
	>=gnome-extra/libgda-2.99.6:3
	>=gnome-base/gconf-2:2
	>=x11-libs/gtk+-2.6:2
	>=dev-libs/libxml2-2:2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2:2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.28
	app-text/scrollkeeper
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README TODO"

pkg_setup() {
	G2CONF="$(use_enable debug debug-signal)"
}

#src_prepare() {
#	gnome2_src_prepare

	# Updates to fix compilation problems due to recent API changes
#	epatch "${FILESDIR}/${P}-api_updates.patch"

#	eautoreconf
#}
