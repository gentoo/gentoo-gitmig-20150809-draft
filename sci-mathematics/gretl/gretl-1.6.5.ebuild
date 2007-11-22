# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gretl/gretl-1.6.5.ebuild,v 1.3 2007/11/22 00:23:50 bicatali Exp $

inherit eutils gnome2

DESCRIPTION="Regression, econometrics and time-series library"
HOMEPAGE="http://gretl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# 1.6.5 too buggy without nls. now forcing.
#IUSE="accessibility gmp gnome gtk nls png readline sourceview"
IUSE="accessibility gmp gnome gtk png readline sourceview"

RDEPEND="dev-libs/libxml2
	>=dev-libs/glib-2
	sci-visualization/gnuplot
	virtual/lapack
	>=sci-libs/fftw-3
	dev-libs/mpfr
	png? ( media-libs/libpng )
	readline? ( sys-libs/readline )
	gmp? ( dev-libs/gmp )
	accessibility? ( app-accessibility/flite )
	gtk? ( >=x11-libs/gtk+-2.0
		gnome? ( >=gnome-base/libgnomeui-2.0
				 >=gnome-base/libgnomeprint-2.2
				 >=gnome-base/libgnomeprintui-2.2
				 >=gnome-base/gconf-2.0 )
		sourceview? ( x11-libs/gtksourceview ) )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix when nls not selected (bug #198720)
	epatch "${FILESDIR}"/${P}-nls.patch
	# makefile in cli not propagating flags
	epatch "${FILESDIR}"/${P}-cli.patch
}

src_compile() {

	local myconf
	if use gtk; then
		if ! built_with_use sci-visualization/gnuplot gd; then
			eerror "You need to build gnuplot with gd and png to use the gretl gtk GUI"
			die "configuring with gnuplot failed"
		fi
		myconf="--enable-gui"
		myconf="${myconf} $(use_with sourceview gtksourceview)"
		myconf="${myconf} $(use_with gnome)"
	else
		myconf="--disable-gui --disable-gnome --disable-gtksourceview"
	fi

	econf \
		--with-nls \
		--with-mpfr \
		--without-libole2 \
		--without-gtkextra \
		$(use_enable png png-comments) \
		$(use_with readline) \
		$(use_with gmp) \
		$(use_with accessibility audio) \
		${myconf} \
		LAPACK_LIBS="$(pkg-config --libs lapack)" \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	if use gnome; then
		gnome2_src_install gnome_prefix="${D}"/usr
	else
		einstall || "die einstall failed"
	fi
	if use gtk && ! use gnome; then
		doicon gnome/gretl.png
		make_desktop_entry gretlx11 gretl
	fi
	dodoc NEWS README README.audio ChangeLog TODO EXTENDING \
		|| die "dodoc failed"
}
