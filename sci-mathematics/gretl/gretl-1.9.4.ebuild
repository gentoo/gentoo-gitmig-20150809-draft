# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gretl/gretl-1.9.4.ebuild,v 1.3 2011/03/14 21:19:15 bicatali Exp $

USE_EINSTALL=true
EAPI=2
inherit eutils gnome2 elisp-common

DESCRIPTION="Regression, econometrics and time-series library"
HOMEPAGE="http://gretl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="accessibility emacs gnome gtk nls odbc openmp readline R sourceview static-libs"

RDEPEND="
	dev-libs/libxml2:2
	dev-libs/glib:2
	>=sci-visualization/gnuplot-4.2
	virtual/lapack
	virtual/latex-base
	sci-libs/fftw:3.0
	dev-libs/gmp
	dev-libs/mpfr
	readline? ( sys-libs/readline )
	accessibility? ( app-accessibility/flite )
	gtk?  ( sci-visualization/gnuplot[gd]
			media-libs/gd[png]
			x11-libs/gtk+:2 )
	gnome? ( sci-visualization/gnuplot[gd]
			 media-libs/gd[png]
			 gnome-base/libgnomeui
			 gnome-base/gconf:2 )
	R? ( dev-lang/R )
	sourceview? ( x11-libs/gtksourceview:2.0 )
	odbc? ( dev-db/unixODBC )
	emacs? ( virtual/emacs )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

SITEFILE=50${PN}-gentoo.el

pkg_setup() {
	if use openmp &&
		[[ $(tc-getCC)$ == *gcc* ]] &&
		( [[ $(gcc-major-version)$(gcc-minor-version) -lt 42 ]] ||
			! has_version sys-devel/gcc[openmp] )
	then
		ewarn "You are using gcc and OpenMP is only available with gcc >= 4.2 "
		die "Need an OpenMP capable compiler"
	fi
}

src_configure() {
	local myconf
	if use gtk; then
		myconf="--enable-gui"
		myconf="${myconf} $(use_with sourceview gtksourceview)"
		myconf="${myconf} $(use_with gnome)"
	else
		myconf="--disable-gui --without-gnome --without-gtksourceview"
	fi

	econf \
		--disable-rpath \
		--enable-shared \
		--with-mpfr \
		$(use_enable nls) \
		$(use_enable openmp) \
		$(use_enable static-libs static) \
		$(use_with readline) \
		$(use_with odbc) \
		$(use_with accessibility audio) \
		$(use_with R libR) \
		${myconf} \
		LAPACK_LIBS="$(pkg-config --libs lapack)"
}

src_compile() {
	emake || die "emake failed"
	if use emacs; then
		elisp-compile utils/emacs/gretl.el || die "elisp-compile failed"
	fi
}

src_install() {
	if use gnome; then
		gnome2_src_install gnome_prefix="${D}"/usr svprefix="${D}usr"
	else
		einstall svprefix="${D}usr"
	fi
	if use gtk && ! use gnome; then
		doicon gnome/gretl.png
		make_desktop_entry gretl_x11 gretl
	fi
	if use emacs; then
		elisp-install ${PN} utils/emacs/gretl.{el,elc} \
			|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
			|| die "elisp-site-file-install failed"
	fi
	dodoc README README.audio ChangeLog CompatLog
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
