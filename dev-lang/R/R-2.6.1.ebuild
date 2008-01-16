# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/R/R-2.6.1.ebuild,v 1.2 2008/01/16 16:26:19 bicatali Exp $

inherit fortran flag-o-matic

DESCRIPTION="Language and environment for statistical computing and graphics"
HOMEPAGE="http://www.r-project.org/"
SRC_URI="mirror://cran/src/base/R-2/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="doc java jpeg lapack minimal nls png readline tk X"

# common depends
CDEPEND="dev-lang/perl
	>=dev-libs/libpcre-7.3
	app-arch/bzip2
	virtual/blas
	virtual/ghostscript
	readline? ( sys-libs/readline )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	lapack? ( virtual/lapack )
	tk? ( dev-lang/tk )
	X? ( x11-libs/libXmu x11-misc/xdg-utils )"

DEPEND="${CDEPEND}
	dev-util/pkgconfig
	doc? ( virtual/latex-base
	  || ( dev-texlive/texlive-fontsrecommended virtual/tetex ) )"

RDEPEND="${CDEPEND}
	java? ( >=virtual/jre-1.5 )"

pkg_setup() {
	FORTRAN="gfortran ifc g77"
	fortran_pkg_setup
	export FFLAGS="${FFLAGS:--O2}"
	[[ ${FORTRANC} = gfortran || ${FORTRANC} = if* ]] && \
		export FCFLAGS="${FCFLAGS:-${FFLAGS}}"

	filter-ldflags -Wl,-Bdirect -Bdirect

	# this is needed to properly compile additional R packages
	# (see bug #152379)
	append-flags -std=gnu99
}

src_compile() {
	use lapack && \
		export LAPACK_LIBS="$(pkg-config --libs lapack)"

	if use X; then
		export R_BROWSER="$(type -p xdg-open)"
		export R_PDFVIEWER="$(type -p xdg-open)"
	fi

	econf \
		--enable-R-profiling \
		--enable-memory-profiling \
		--enable-R-shlib \
		--enable-linux-lfs \
		--with-system-zlib \
		--with-system-bzlib \
		--with-system-pcre \
		--with-blas="$(pkg-config --libs blas)" \
		--docdir=/usr/share/doc/${PF} \
		rdocdir=/usr/share/doc/${PF} \
		$(use_enable nls) \
		$(use_with lapack) \
		$(use_with tk tcltk) \
		$(use_with jpeg jpeglib) \
		$(use_with !minimal recommended-packages) \
		$(use_with png libpng) \
		$(use_with readline) \
		$(use_with X x) \
		|| die "econf failed"
	emake || die "emake failed"

	if use doc; then
		export VARTEXFONTS="${T}/fonts"
		emake info pdf || die "emake docs failed"
	fi
}

src_install() {
	# -j1 because creates various dirs sequentially (hit should be small)
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		emake DESTDIR="${D}" \
			install-info install-pdf || die "emake install docs failed"
	fi

	# env files
	echo "LDPATH=\"/usr/$(get_libdir)/R/lib\"" > 99R
	doenvd 99R || die "doenvd failed"

	# dealing with licenses
	rm -f "${D}"usr/share/doc/${PF}/{COPYING,COPYING.LIB}
	dosym "${PORTDIR}"/licenses/GPL-2 /usr/share/doc/${PF}/COPYING
	dosym "${PORTDIR}"/licenses/LGPL-2.1 /usr/share/doc/${PF}/COPYING.LIB
}

pkg_config() {
	if use java; then
		einfo "Re-initializing java paths for ${P}"
		R CMD javareconf
	fi
}
