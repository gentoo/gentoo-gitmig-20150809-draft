# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/dconf/dconf-0.5.1-r1.ebuild,v 1.2 2010/12/11 21:59:57 xmw Exp $

EAPI=3
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="Simple low-level configuration system"
HOMEPAGE="http://live.gnome.org/dconf"
SRC_URI="${SRC_URI} mirror://gentoo/introspection.m4.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~sparc ~x86"
IUSE="doc +introspection vala"

RDEPEND=">=dev-libs/glib-2.25.16
	>=dev-libs/libgee-0.5.1
	>=dev-libs/libxml2-2.7.7
	x11-libs/gtk+:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.3 )
	vala? ( >=dev-lang/vala-0.9.5:0.10 )"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.15 )"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable introspection)
		$(use_enable vala)
		VALAC=$(type -p valac-0.10)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix vala automagic support, upstream bug #634171
	epatch "${FILESDIR}/${P}-automagic-vala.patch"

	mv "${WORKDIR}"/introspection.m4 . || die
	mkdir -p m4 || die
	AT_M4DIR="." eautoreconf
}
