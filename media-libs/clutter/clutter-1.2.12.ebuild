# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter/clutter-1.2.12.ebuild,v 1.2 2010/09/25 13:44:10 eva Exp $

EAPI="2"

inherit clutter

DESCRIPTION="Clutter is a library for creating graphical user interfaces"

SLOT="1.0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="debug doc +gtk +introspection"

RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/cairo-1.4
	>=x11-libs/pango-1.20[introspection?]
	>=dev-libs/json-glib-0.8[introspection?]

	virtual/opengl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXdamage
	x11-libs/libXi
	x11-proto/inputproto
	>=x11-libs/libXfixes-3
	>=x11-libs/libXcomposite-0.4

	gtk? ( >=x11-libs/gtk+-2.0 )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/gtk-doc-am-1.11
	doc? (
		>=dev-util/gtk-doc-1.11
		>=app-text/docbook-sgml-utils-0.6.14[jadetex]
		dev-libs/libxslt )
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )"

src_configure() {
	# XXX: Conformance test suite (and clutter itself) does not work under Xvfb
	# XXX: Profiling, coverage disabled for now
	# FIXME: Uses internal json-glib
	local myconf="
		--enable-debug=minimum
		--enable-cogl-debug=minimum
		--enable-conformance=no
		--disable-gcov
		--enable-profile=no
		--enable-maintainer-flags=no
		--enable-xinput
		--with-json=system
		--with-flavour=glx
		--with-imagebackend=gdk-pixbuf
		$(use_enable introspection)
		$(use_enable doc docs)"

	if ! use gtk; then
		myconf="${myconf} --with-imagebackend=internal"
		# Internal image backend is experimental
		ewarn "You have selected the experimental internal image backend"
	fi

	if use debug; then
		myconf="${myconf}
			--enable-debug=yes
			--enable-cogl-debug=yes"
	fi

	econf ${myconf}
}
