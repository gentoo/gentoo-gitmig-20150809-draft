# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.9.1.ebuild,v 1.2 2010/11/23 17:50:12 jlec Exp $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit."
HOMEPAGE="http://wxwidgets.org/"

SRC_URI="mirror://sourceforge/wxwindows/wxWidgets-${PV}.tar.bz2
	doc? ( mirror://sourceforge/wxwindows/wxWidgets-docs-html-${PV}.tar.bz2 )"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X doc debug gnome gstreamer opengl pch sdl tiff"

RDEPEND="
	dev-libs/expat
	sdl?    ( media-libs/libsdl )
	X?  (
		>=x11-libs/gtk+-2.18
		>=dev-libs/glib-2.22
		virtual/jpeg
		x11-libs/libSM
		x11-libs/libXinerama
		x11-libs/libXxf86vm
		gnome? ( gnome-base/libgnomeprintui )
		gstreamer? (
			>=gnome-base/gconf-2.0
			>=media-libs/gstreamer-0.10 )
		opengl? ( virtual/opengl )
		tiff?   ( media-libs/tiff )
		)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	X?  (
		x11-proto/xproto
		x11-proto/xineramaproto
		x11-proto/xf86vidmodeproto
		)"
#		test? ( dev-util/cppunit )

PDEPEND=">=app-admin/eselect-wxwidgets-1.4"

SLOT="2.9"
LICENSE="wxWinLL-3
		GPL-2
		doc?	( wxWinFDL-3 )"

S="${WORKDIR}/wxWidgets-${PV}"

src_unpack() {
	unpack wxWidgets-${PV}.tar.bz2
	if use doc; then
		cd "${S}"/docs
		unpack wxWidgets-docs-html-${PV}.tar.bz2
		mv "${S}"/docs/wxWidgets-${PV} "${S}"/docs/html
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.9.1-collision.patch
}

src_configure() {
	local myconf

	append-flags -fno-strict-aliasing

	# X independent options
	myconf="--enable-compat26
			--with-zlib=sys
			--with-expat=sys
			$(use_enable pch precomp-headers)
			$(use_with sdl)"

	# debug in >=2.9
	#   if USE="debug", set max debug level (wxDEBUG_LEVEL=2)
	#   if USE="-debug" use the default (wxDEBUG_LEVEL=1)
	#   do not use --disable-debug
	# this means we always provide debugging support in the library, and
	# apps can now enable/disable debugging on an individual basis without
	# needing to care about what flags wxGTK was built with.
	# http://groups.google.com/group/wx-dev/browse_thread/thread/c3c7e78d63d7777f/05dee25410052d9c
	use debug \
		&& myconf="${myconf} --enable-debug=max"

	# wxGTK options
	#   --enable-graphics_ctx - needed for webkit, editra
	#   --without-gnomevfs - bug #203389

	use X && \
		myconf="${myconf}
			--enable-graphics_ctx
			--enable-gui
			--with-libpng=sys
			--with-libxpm=sys
			--with-libjpeg=sys
			--without-gnomevfs
			$(use_enable gstreamer mediactrl)
			$(use_with opengl)
			$(use_with gnome gnomeprint)
			$(use_with !gnome gtkprint)
			$(use_with tiff libtiff sys)"

	# wxBase options
	use X || \
		myconf="${myconf}
			--disable-gui"

	mkdir "${S}"/wxgtk_build
	cd "${S}"/wxgtk_build

	ECONF_SOURCE="${S}" econf ${myconf} || die "configure failed."
}

src_compile() {
	cd "${S}"/wxgtk_build
	emake || die "make failed."
}

#src_test() {
#	cd "${S}"/wxgtk_build/tests
#	emake || die "failed building testsuite"
#	# currently fails
#	./test -d || ewarn "failed running testsuite"
#}

src_install() {
	cd "${S}"/wxgtk_build

	emake DESTDIR="${D}" install || die "install failed."

	cd "${S}"/docs
	dodoc changes.txt readme.txt
	newdoc base/readme.txt base_readme.txt
	newdoc gtk/readme.txt gtk_readme.txt

	if use doc; then
		dohtml -r "${S}"/docs/html/*
	fi
}

pkg_postinst() {
	has_version app-admin/eselect-wxwidgets \
		&& eselect wxwidgets update
}

pkg_postrm() {
	has_version app-admin/eselect-wxwidgets \
		&& eselect wxwidgets update
}
