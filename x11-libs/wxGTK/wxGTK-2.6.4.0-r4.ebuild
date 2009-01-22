# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.6.4.0-r4.ebuild,v 1.10 2009/01/22 12:50:49 armin76 Exp $

inherit eutils versionator flag-o-matic

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit."
HOMEPAGE="http://wxwidgets.org/"

BASE_PV="$(get_version_component_range 1-3)"
BASE_P="${PN}-${BASE_PV}"

# we use the wxPython tarballs because they include the full wxGTK sources and
# are released more frequently than wxGTK.
SRC_URI="mirror://sourceforge/wxpython/wxPython-src-${PV}.tar.bz2
		doc? ( mirror://sourceforge/wxwindows/wxWidgets-${BASE_PV}-HTML.tar.gz )"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="X doc debug gnome odbc opengl pch sdl unicode"

RDEPEND="
	dev-libs/expat
	odbc?	( dev-db/unixODBC )
	sdl?	( media-libs/libsdl )
	X?	(
		>=x11-libs/gtk+-2.0
		>=dev-libs/glib-2.0
		media-libs/jpeg
		media-libs/tiff
		x11-libs/libSM
		x11-libs/libXinerama
		x11-libs/libXxf86vm
		gnome?	( gnome-base/libgnomeprintui )
		opengl?	( virtual/opengl )
		)"

DEPEND="${RDEPEND}
		dev-util/pkgconfig
		X?	(
			x11-proto/xproto
			x11-proto/xineramaproto
			x11-proto/xf86vidmodeproto
			)"

PDEPEND=">=app-admin/eselect-wxwidgets-0.7"

SLOT="2.6"
LICENSE="wxWinLL-3
		GPL-2
		odbc? ( LGPL-2 )
		doc? ( wxWinFDL-3 )"

S="${WORKDIR}/wxPython-src-${PV}"
HTML_S="${WORKDIR}/wxWidgets-${BASE_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# General Patches

	epatch "${FILESDIR}"/${PN}-2.6.3-unicode-odbc.patch
	epatch "${FILESDIR}"/${BASE_P}-collision.patch
	epatch "${FILESDIR}"/${BASE_P}-mmedia.patch				# Bug #174874

	# Patches Specific to this version

	epatch "${FILESDIR}"/${P}-wxrc_link_fix.patch
	epatch "${FILESDIR}"/${P}-g_free.patch

	# Reverse apply patch in wxPython tarball that breaks ABI
	EPATCH_SINGLE_MSG="Reversing listctrl-ongetitemcolumnimage.patch ..." \
		EPATCH_OPTS="-R" epatch "${S}"/patches/listctrl-ongetitemcolumnimage.patch

	# wxBase has an automagic sdl dependency.  short circuit it here.
	# http://bugs.gentoo.org/show_bug.cgi?id=91574
	use sdl || sed -i -e 's:$wxUSE_LIBSDL" != "no":$wxUSE_LIBSDL" = "yes":' configure
}

src_compile() {
	local myconf

	append-flags -fno-strict-aliasing

	# X independent options
	myconf="--enable-shared
			--enable-compat24
			--with-regex=builtin
			--with-zlib=sys
			--with-expat
			$(use_enable pch precomp-headers)
			$(use_with sdl)
			$(use_with odbc)"

	# wxGTK only
	use X && \
		myconf="${myconf}
			--enable-gui
			--with-libpng
			--with-libxpm
			--with-libjpeg
			--with-libtiff
			$(use_enable opengl)
			$(use_with opengl)
			$(use_with gnome gnomeprint)"

	# wxBase only
	use X || \
		myconf="${myconf}
			--disable-gui"

	# in 2.6 we always build ansi
	# everything else is controlled by USE
	if ! use debug; then
		build_wx ansi
	else
		build_wx ansi-debug
	fi

	if use unicode; then
		if ! use debug; then
			build_wx unicode
		else
			build_wx unicode-debug
		fi
	fi
}

src_install() {
	# Note - the last version to be installed becomes the default, so install
	# ansi after unicode
	install_wx unicode
	install_wx unicode-debug
	install_wx ansi
	install_wx ansi-debug

	dodoc "${S}"/docs/changes.txt
	dodoc "${S}"/docs/gtk/readme.txt

	if use doc; then
		dohtml -r "${HTML_S}"/docs/html/*
	fi

	# We don't want this
	rm "${D}"/usr/share/locale/it/LC_MESSAGES/wxmsw.mo
}

pkg_postinst() {
	has_version app-admin/eselect-wxwidgets \
		&& eselect wxwidgets update
}

pkg_postrm() {
	has_version app-admin/eselect-wxwidgets \
		&& eselect wxwidgets update
}

build_wx() {
	local build_wx_conf

	case "$1" in
		ansi)
			build_wx_conf="${build_wx_conf}
			--disable-unicode"
		;;

		ansi-debug)
			build_wx_conf="${build_wx_conf}
			--disable-unicode
			--enable-debug_flag"
		;;

		unicode)
			build_wx_conf="${build_wx_conf}
			--enable-unicode"
		;;

		unicode-debug)
			build_wx_conf="${build_wx_conf}
			--enable-unicode
			--enable-debug_flag"
		;;

		*)
			eerror "wxlib.class: build_wx called with invalid argument(s)."
			die "wxlib.class: build_wx called with invalid argument(s)."
		;;
	esac

	mkdir -p build_$1
	pushd build_$1

	ECONF_SOURCE="${S}" econf \
		${myconf} \
		${build_wx_conf} \
		|| die "Failed to configure $1."

	emake || die "Failed to make $1."

	if [[ -e contrib/src ]]; then
		cd contrib/src
		emake || die "Failed to make $1 contrib."
	fi

	popd
}

install_wx() {
	if [[ -d build_$1 ]]; then
		pushd build_$1
		emake DESTDIR="${D}" install || die "Failed to install $1."
		if [[ -e contrib/src ]]; then
			cd contrib/src
			emake DESTDIR="${D}" install || die "Failed to install $1 contrib."
		fi
		popd
	fi
}
