# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter/clutter-1.5.8.ebuild,v 1.1 2010/12/05 14:37:51 nirbheek Exp $

EAPI="2"

inherit clutter

DESCRIPTION="Clutter is a library for creating graphical user interfaces"

SLOT="1.0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="debug doc +gtk +introspection"

# NOTE: glx flavour uses libdrm + >=mesa-7.3
RDEPEND=">=dev-libs/glib-2.26
	>=x11-libs/cairo-1.10
	>=x11-libs/pango-1.20[introspection?]
	>=dev-libs/json-glib-0.12[introspection?]
	>=dev-libs/atk-1.7

	virtual/opengl
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXdamage
	x11-libs/libXi
	x11-proto/inputproto
	>=x11-libs/libXfixes-3
	>=x11-libs/libXcomposite-0.4

	gtk? ( || (
		x11-libs/gdk-pixbuf
		>=x11-libs/gtk+-2.0 ) )
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/gtk-doc-am-1.13
	doc? (
		>=dev-util/gtk-doc-1.13
		>=app-text/docbook-sgml-utils-0.6.14[jadetex]
		dev-libs/libxslt )
"
DOCS="AUTHORS README NEWS ChangeLog*"

src_configure() {
	# We only need conformance tests, the rest are useless for us
	sed -e 's/^\(SUBDIRS =\).*/\1/g' \
		-i tests/Makefile.am || die "am tests sed failed"
	sed -e 's/^\(SUBDIRS =\).*/\1/g' \
		-i tests/Makefile.in || die "in tests sed failed"

	# XXX: Conformance test suite (and clutter itself) does not work under Xvfb
	# XXX: Profiling, coverage disabled for now
	# XXX: What about eglx/eglnative/opengl-egl-xlib/osx/wayland/etc flavours?
	local myconf="
		--enable-debug=minimum
		--enable-cogl-debug=minimum
		--enable-conformance=no
		--disable-gcov
		--enable-profile=no
		--enable-maintainer-flags=no
		--enable-xinput
		--with-flavour=glx
		--with-imagebackend=gdk-pixbuf
		$(use_enable introspection)
		$(use_enable doc docs)
		$(use_enable doc cogl2-reference)"

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
