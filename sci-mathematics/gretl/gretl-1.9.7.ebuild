# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gretl/gretl-1.9.7.ebuild,v 1.1 2012/01/03 02:44:19 bicatali Exp $

USE_EINSTALL=true
EAPI=4
inherit eutils gnome2 elisp-common

DESCRIPTION="Regression, econometrics and time-series library"
HOMEPAGE="http://gretl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="accessibility emacs gnome gtk gtk3 nls odbc openmp readline sse2 R static-libs"

RDEPEND="dev-libs/libxml2:2
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
			x11-libs/gtk+:2
			x11-libs/gtksourceview:2.0 )
	gtk3? ( sci-visualization/gnuplot[gd]
			media-libs/gd[png]
			x11-libs/gtk+:3
			x11-libs/gtksourceview:3.0 )
	gnome? ( sci-visualization/gnuplot[gd]
			 media-libs/gd[png]
			 gnome-base/libgnomeui
			 gnome-base/gconf:2 )
	R? ( dev-lang/R )
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
	econf \
		--disable-rpath \
		--enable-shared \
		--with-mpfr \
		$(use_enable gtk gui) \
		$(use_enable gtk3) \
		$(use_enable nls) \
		$(use_enable openmp) \
		$(use_enable sse2) \
		$(use_enable static-libs static) \
		$(use_with accessibility audio) \
		$(use_with gnome) \
		$(use_with odbc) \
		$(use_with readline) \
		$(use_with R libR) \
		${myconf} \
		LAPACK_LIBS="$(pkg-config --libs lapack)"
}

src_compile() {
	emake
	if use emacs; then
		elisp-compile utils/emacs/gretl.el || die "elisp-compile failed"
	fi
}

src_install() {
	if use gnome; then
		gnome2_src_install gnome_prefix="${ED}"/usr svprefix="${ED}usr"
	else
		einstall svprefix="${ED}usr"
	fi
	if use gtk || use gtk3 && ! use gnome; then
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
