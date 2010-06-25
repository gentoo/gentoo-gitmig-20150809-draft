# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter/clutter-1.0.10.ebuild,v 1.2 2010/06/25 14:14:56 nirbheek Exp $

EAPI="2"

inherit autotools clutter

DESCRIPTION="Clutter is a library for creating graphical user interfaces"

SLOT="1.0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc +gtk +introspection +opengl"

RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/cairo-1.4
	>=x11-libs/pango-1.20[introspection?]

	gtk? ( >=x11-libs/gtk+-2.0 )
	opengl? (
		virtual/opengl
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXdamage
		x11-libs/libXi
		x11-proto/inputproto

		>=x11-libs/libXfixes-3
		>=x11-libs/libXcomposite-0.4 )
	!opengl? ( media-libs/libsdl )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/gtk-doc-am
	doc? (
		>=dev-util/gtk-doc-1.11
		>=app-text/docbook-sgml-utils-0.6.14[jadetex]
		app-text/xmlto )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )"

src_configure() {
	local myconf=""

	if use opengl; then
		elog "Using GLX for OpenGL backend"
		myconf="${myconf} --with-flavour=glx"
	else
		elog "Using SDL for OpenGL backend"
		myconf="${myconf} --with-flavour=sdl"
		ewarn "You have disabled OpenGL, do not report bugs about breakage"
	fi

	if use gtk; then
		myconf="${myconf} --with-imagebackend=gdk-pixbuf"
	else
		myconf="${myconf} --with-imagebackend=internal"
		# Internal image backend is experimental
		ewarn "You have selected the experimental internal image backend"
	fi

	if ! use debug; then
		myconf="${myconf}
			--enable-debug=minimum
			--enable-cogl-debug=minimum"
	fi

	# FIXME: Tests are interactive, not of use for us
	# FIXME: Using external json-glib breaks introspection
	myconf="${myconf}
		--disable-tests
		--enable-maintainer-flags=no
		--enable-xinput
		--with-json=internal
		$(use_enable introspection)
		$(use_enable doc manual)"
	econf ${myconf}
}

src_prepare() {
	# Make it libtool-1 compatible
	rm -v build/autotools/lt* build/autotools/libtool.m4 || die "removing libtool macros failed"

	# FIXME: Tests are interactive, not of use for us
	epatch "${FILESDIR}/${PN}-1.0.0-disable-tests.patch"

	eautoreconf
}
