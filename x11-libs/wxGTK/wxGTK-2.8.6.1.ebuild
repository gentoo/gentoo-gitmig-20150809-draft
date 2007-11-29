# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.8.6.1.ebuild,v 1.1 2007/11/29 01:48:30 dirtyepic Exp $

EAPI=1

inherit eutils versionator flag-o-matic

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit."
HOMEPAGE="http://wxwidgets.org/"

BASE_PV="$(get_version_component_range 1-3)"
BASE_P="${PN}-${BASE_PV}"

# we use the wxPython tarballs because they include the full wxGTK sources and
# are released more frequently than wxGTK.
SRC_URI="mirror://sourceforge/wxpython/wxPython-src-${PV}.tar.bz2
		doc? ( mirror://sourceforge/wxwindows/wxWidgets-${BASE_PV}-HTML.zip )"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X doc debug gnome gstreamer odbc opengl sdl"

RDEPEND="
	dev-libs/expat
	odbc?   ( dev-db/unixODBC )
	sdl?    ( media-libs/libsdl )
	X?  (
		x11-libs/gtk+:2
		dev-libs/glib:2
		media-libs/jpeg
		media-libs/tiff
		x11-libs/libSM
		x11-libs/libXinerama
		x11-libs/libXxf86vm
		gnome?  (
				gnome-base/libgnomeprintui
				gnome-base/gnome-vfs
				)
		gstreamer? ( media-libs/gstreamer:0.10 )
		opengl? ( virtual/opengl )
		)"

DEPEND="${RDEPEND}
		dev-util/pkgconfig
		app-admin/eselect-wxwidgets
		X?  (
			x11-proto/xproto
			x11-proto/xineramaproto
			x11-proto/xf86vidmodeproto
			)"

SLOT="2.8"
LICENSE="wxWinLL-3
		GPL-2
		odbc?	( LGPL-2 )
		doc?	( wxWinFDL-3 )"

S="${WORKDIR}/wxPython-src-${PV}"
HTML_S="${WORKDIR}/wxWidgets-${BASE_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# General patches

	epatch "${FILESDIR}"/${PN}-2.6.3-unicode-odbc.patch
	epatch "${FILESDIR}"/${PN}-2.8.4-collision.patch

	# Patches specific to this Version

	epatch "${FILESDIR}"/${PN}-2.8.6-extralibs-media.patch
}

src_compile() {
	local myconf

	append-flags -fno-strict-aliasing

	# configure notes:
	#   --disable-precomp-headers saves us about 800MiB of disk space and 1/3
	#   compile time

	# X independent options
	myconf="--enable-compat26
			--enable-shared
			--enable-unicode
			--with-regex=builtin
			--with-zlib=sys
			--with-expat
			--disable-precomp-headers
			$(use_enable debug)
			$(use_with sdl)
			$(use_with odbc)"

	# wxGTK options
	use X && \
		myconf="${myconf}
			--enable-gui
			--with-libpng
			--with-libxpm
			--with-libjpeg
			--with-libtiff
			$(use_enable gstreamer mediactrl)
			$(use_enable opengl)
			$(use_with opengl)
			$(use_with gnome gnomeprint)
			$(use_with gnome gnomevfs)"

	# wxBase options
	use X || \
		myconf="${myconf}
			--disable-gui"

	mkdir "${S}"/wxgtk_build
	cd "${S}"/wxgtk_build

	ECONF_SOURCE="${S}" econf ${myconf} || die "configure failed."

	emake || die "make failed."

	if [[ -d contrib/src ]]; then
		cd contrib/src
		emake || die "make contrib failed."
	fi
}

src_install() {
	cd "${S}"/wxgtk_build

	emake DESTDIR="${D}" install || die "install failed."

	if [[ -d contrib/src ]]; then
		cd contrib/src
		emake DESTDIR="${D}" install || die "install contrib failed."
	fi

	if use doc; then
		dohtml -r "${HTML_S}"/docs/html/*
	fi

	# We don't want this
	rm "${D}"usr/share/locale/it/LC_MESSAGES/wxmsw.mo
}

pkg_postinst() {
	if [[ ! -e /var/lib/wxwidgets/current \
		|| $(grep 'WXCONFIG="none"' /var/lib/wxwidgets/current) ]]; then
		local wxchar wxtoolkit wxdebug
		[[ ${SLOT} == 2.6 ]] && wxchar=ansi || wxchar=unicode
		use X && wxtoolkit=gtk2 || wxtoolkit=base
		use debug && wxdebug=debug || wxdebug=release

		eselect wxwidgets set ${wxtoolkit}-${wxchar}-${wxdebug}-${SLOT}
	else
		eselect wxwidgets update
	fi
}

pkg_postrm() {
	eselect wxwidgets update
}
