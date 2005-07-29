# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.6.1.ebuild,v 1.3 2005/07/29 12:17:12 swegener Exp $

inherit wxlib gnuconfig

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit and
wxbase non-gui library"

SLOT="2.6"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~amd64 ~ia64 ~hppa ~ppc64"
IUSE="gnome gtk2 joystick odbc opengl sdl wxgtk1"

RDEPEND="${RDEPEND}
	opengl? ( virtual/opengl )
	gtk2? ( >=x11-libs/gtk+-2.0
		>=dev-libs/glib-2.0 )
	wxgtk1? ( =x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2* )
	wxgtk1? ( gtk2? ( media-libs/libpng
		media-libs/jpeg
		media-libs/tiff ) )
	odbc? ( dev-db/unixODBC )
	!mips? ( !arm? ( !hppa? ( !ia64? ( !ppc64? ( !alpha? ( !sparc? ( sdl? ( media-libs/sdl-sound ) ) ) ) ) ) ) )"

DEPEND="${RDEPEND}
	${DEPEND}
	gtk2? ( dev-util/pkgconfig )"
S=${WORKDIR}/wxWidgets-${PV}

pkg_setup() {
	einfo "To install only wxbase (non-gui libs) use -gtk2 -wxgtk1"
	if use unicode; then
		! use gtk2 && die "You must put gtk2 in your USE if you need unicode support"
	fi
}

src_compile() {
	gnuconfig_update
	if use wxgtk1 || use gtk2; then
		myconf="${myconf}
			--with-png
			--with-jpeg
			--with-tiff
			$(use_enable opengl)
			$(use_with opengl)
			$(use_with gnome gnomeprint)
			$(use_with sdl)
			$(use_enable joystick)"
	fi

	use wxgtk1 && \
		configure_build gtk1 "" "${myconf} --with-gtk=1"

	use gtk2 && \
		configure_build gtk2 unicode "${myconf} --with-gtk=2"

	! use gtk2 && ! use wxgtk1 && \
		configure_build base unicode "--disable-gui"
}

src_install() {
	use wxgtk1 && install_build gtk1
	use gtk2 && install_build gtk2
	! use gtk2 && ! use wxgtk1 && install_build base

	wxlib_src_install
}

pkg_postinst() {
	einfo "dev-libs/wxbase has been removed from portage and can be"
	einfo "installed with wxGTK by specifying the USE flags"
	einfo "-gtk2 and -wxgtk1"
}
