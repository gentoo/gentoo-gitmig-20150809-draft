# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gretl/gretl-1.7.7.ebuild,v 1.1 2008/08/30 16:59:25 bicatali Exp $

USE_EINSTALL=true
EAPI=1
inherit eutils gnome2 elisp-common

DESCRIPTION="Regression, econometrics and time-series library"
HOMEPAGE="http://gretl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="accessibility emacs gmp gnome gtk nls odbc readline sourceview"

RDEPEND="dev-libs/libxml2
	dev-libs/glib:2
	sci-visualization/gnuplot
	virtual/lapack
	virtual/latex-base
	sci-libs/fftw:3.0
	dev-libs/mpfr
	readline? ( sys-libs/readline )
	gmp? ( dev-libs/gmp )
	accessibility? ( app-accessibility/flite )
	gtk? ( >=x11-libs/gtk+-2.10:2 )
	gnome? ( gnome-base/libgnomeui
			 gnome-base/libgnomeprint:2.2
			 gnome-base/libgnomeprintui:2.2
			 gnome-base/gconf:2 )
	sourceview? ( x11-libs/gtksourceview )
	odbc? ( dev-db/unixODBC )
	emacs? ( virtual/emacs )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

SITEFILE=50${PN}-gentoo.el

pkg_setup() {
	if use gtk && ! built_with_use sci-visualization/gnuplot gd; then
		eerror "gretl gtk GUI needs gnuplot with gd and gd with png"
		die "Please install gnuplot with gd and png use flags enabled"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.7.5-locale.patch
	epatch "${FILESDIR}"/${PN}-1.7.6-ldflags.patch
}

src_compile() {

	local myconf
	if use gtk; then
		myconf="--enable-gui"
		myconf="${myconf} $(use_with sourceview gtksourceview)"
		myconf="${myconf} $(use_with gnome)"
	else
		myconf="--disable-gui --without-gnome --without-gtksourceview"
	fi

	econf \
		--with-mpfr \
		$(use_enable nls) \
		$(use_with readline) \
		$(use_with gmp) \
		$(use_with odbc) \
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
		einstall || die "einstall failed"
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
	dodoc README README.audio ChangeLog CompatLog TODO \
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
