# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgdata/libgdata-0.5.0.ebuild,v 1.2 2009/10/30 16:38:51 mr_bones_ Exp $

EAPI="2"

inherit eutils gnome2

DESCRIPTION="GLib-based library for accessing online service APIs using the GData protocol"
HOMEPAGE="http://live.gnome.org/libgdata"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gnome"

RDEPEND=">=dev-libs/glib-2.19.0
	>=net-libs/libsoup-2.26.1:2.4[gnome?]
	>=dev-libs/libxml2-2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

# FIXME: fails testsuite, upstream bug #598801
RESTRICT="test"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable gnome)"
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check || die "emake check failed"
}
