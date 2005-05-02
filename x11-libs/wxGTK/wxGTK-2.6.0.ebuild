# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.6.0.ebuild,v 1.1 2005/05/02 17:57:03 pythonhead Exp $

inherit wxlib

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"

SLOT="2.6"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~amd64 ~ia64 ~hppa ~ppc64"
IUSE="gnome gtk2 jpeg joystick odbc opengl png sdl tiff wxgtk1 xpm"

RDEPEND="${RDEPEND}
	opengl? ( virtual/opengl )
	gtk2? ( >=x11-libs/gtk+-2.0
		>=dev-libs/glib-2.0 )
	wxgtk1? ( =x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2* )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	xpm? ( virtual/x11 )
	odbc? ( dev-db/unixODBC )
	!mips? ( !arm? ( !hppa? ( !ia64? ( !ppc64? ( !alpha? ( !sparc? ( sdl? ( media-libs/sdl-sound ))))))))"

DEPEND="${RDEPEND}
	${DEPEND}
	gtk2? ( dev-util/pkgconfig )"
S=${WORKDIR}/wxWidgets-${PV}

src_unpack() {
	unpack ${A}
	cd ${S} || die "Couldn't cd to ${S}"
	sed -i "s/-O2//g" configure || die "sed configure failed"
	epatch ${FILESDIR}/${P}-gcc4.patch
	gnuconfig_update
}

src_compile() {
	myconf="${myconf}
		$(use_enable opengl)
		$(use_with png libpng)
		$(use_with jpeg libjpeg)
		$(use_with tiff libtiff)
		$(use_with xpm libxpm) $(use_enable xpm)
		$(use_with opengl)
		$(use_with gnome gnomeprint)
		$(use_with sdl)
		$(use_enable joystick)"

	use wxgtk1 && \
		configure_build gtk1 "" "${myconf} --with-gtk=1"

	use gtk2 && \
		configure_build gtk2 unicode "${myconf} --with-gtk=2"
}

src_install() {
	use wxgtk1 && install_build gtk1
	use gtk2 && install_build gtk2

	wxlib_src_install
}
