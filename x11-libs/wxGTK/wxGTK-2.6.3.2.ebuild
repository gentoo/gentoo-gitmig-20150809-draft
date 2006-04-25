# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.6.3.2.ebuild,v 1.3 2006/04/25 18:19:32 halcy0n Exp $

inherit wxlib gnuconfig versionator flag-o-matic

HTML_PV="$(get_version_component_range 1-3)"
DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit and
wxbase non-gui library"

SRC_URI="mirror://sourceforge/wxpython/wxPython-src-${PV}.tar.gz
	doc? ( mirror://sourceforge/wxwindows/wxWidgets-${HTML_PV}-HTML.tar.gz )"

SLOT="2.6"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gnome joystick odbc opengl sdl X"
RDEPEND="${RDEPEND}
	X? ( opengl? ( virtual/opengl )
		>=x11-libs/gtk+-2.0
		>=dev-libs/glib-2.0
		media-libs/tiff )
	odbc? ( dev-db/unixODBC )
	x86? ( sdl? ( media-libs/sdl-sound ) )
	amd64? ( sdl? ( media-libs/sdl-sound ) )
	ppc? ( sdl? ( media-libs/sdl-sound ) )"

DEPEND="${RDEPEND}
	${DEPEND}
	dev-util/pkgconfig"
S=${WORKDIR}/wxPython-src-${PV}

pkg_setup() {
	if use X; then
		einfo "To install only wxbase (non-gui libs) use USE=-X"
	else
		einfo "To install GUI libraries, in addition to wxbase, use USE=X"
	fi
}

src_compile() {
	gnuconfig_update
	append-flags -fno-strict-aliasing
	myconf="${myconf}
		$(use_with sdl)
		$(use_enable joystick)"

	if use X; then
		myconf="${myconf}
			$(use_enable opengl)
			$(use_with opengl)
			$(use_with gnome gnomeprint)"
	fi

	use X && configure_build gtk2 unicode "${myconf} --with-gtk=2"
	use X || configure_build base unicode "${myconf} --disable-gui"
}

src_install() {
	use X && install_build gtk2
	use X || install_build base

	wxlib_src_install
}

pkg_postinst() {
	einfo "dev-libs/wxbase has been removed from portage."
	einfo "wxBase is installed with wxGTK, as one of many libraries."
	einfo "If only wxBase is wanted, -X USE flag may be specified."
}
