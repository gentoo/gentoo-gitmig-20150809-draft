# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gretl/gretl-1.7.4.ebuild,v 1.1 2008/05/20 13:46:51 markusle Exp $

USE_EINSTALL=true

inherit eutils gnome2 elisp-common

DESCRIPTION="Regression, econometrics and time-series library"
HOMEPAGE="http://gretl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="accessibility emacs gmp gnome gtk nls png readline sourceview"

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
	gtk? ( >=x11-libs/gtk+-2.0 )
	gnome? ( >=gnome-base/libgnomeui-2.0
			 >=gnome-base/libgnomeprint-2.2
			 >=gnome-base/libgnomeprintui-2.2
			 >=gnome-base/gconf-2.0 )
	sourceview? ( x11-libs/gtksourceview )
	emacs? ( virtual/emacs )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	# makefile in cli not propagating flags
	epatch "${FILESDIR}"/${PN}-1.6.5-cli.patch
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
		--with-mpfr \
		--without-libole2 \
		--without-gtkextra \
		$(use_enable nls) \
		$(use_enable png png-comments) \
		$(use_with readline) \
		$(use_with gmp) \
		$(use_with accessibility audio) \
		${myconf} \
		LAPACK_LIBS="$(pkg-config --libs lapack)" \
		|| die "econf failed"

	emake || die "emake failed"

	if use emacs; then
		elisp-compile utils/emacs/gretl.el || die "elisp-compile failed"
	fi
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
	if use emacs; then
		elisp-install ${PN} utils/emacs/gretl.{el,elc} \
			|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
			|| die "elisp-site-file-install failed"
	fi
	dodoc NEWS README README.audio ChangeLog TODO EXTENDING \
		|| die "dodoc failed"
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
		elog "To begin using gretl-mode for all \".inp\" files that you edit,"
		elog "add the following line to your \"~/.emacs\" file:"
		elog "  (add-to-list 'auto-mode-alist '(\"\\\\.inp\\\\'\" . gretl-mode))"
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
