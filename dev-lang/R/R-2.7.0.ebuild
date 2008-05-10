# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/R/R-2.7.0.ebuild,v 1.2 2008/05/10 15:01:59 markusle Exp $

inherit fortran flag-o-matic bash-completion

DESCRIPTION="Language and environment for statistical computing and graphics"
HOMEPAGE="http://www.r-project.org/"
SRC_URI="mirror://cran/src/base/R-2/${P}.tar.gz
	bash-completion? ( mirror://gentoo/R.bash_completion.bz2 )"

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
	app-arch/unzip
	app-arch/zip
	java? ( >=virtual/jre-1.5 )"

R_HOME=/usr/$(get_libdir)/R

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
	# fix packages.html for doc (bug #205103)
	# check in later versions if fixed
	sed -i \
		-e "s:../../library:../../../../$(get_libdir)/R/library:g" \
		src/library/tools/R/packageshtml.R \
		|| die "sed failed"

	# fix Rscript patch
	sed -e "s:-DR_HOME='\"\$(rhome)\"':-DR_HOME='\"/usr/lib/${PN}/\"':" \
		-i src/unix/Makefile.in || die "sed failed"

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

	emake -j1 -C src/nmath/standalone || die "emake math library failed"
}

src_install() {
	# -j1 because creates various dirs sequentially (hit should be small)
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		emake DESTDIR="${D}" \
			install-info install-pdf || die "emake install docs failed"
	fi

	emake -j1 \
		-C src/nmath/standalone \
		DESTDIR="${D}" install \
		|| die "emake install math library failed"

	# env file
	cat > 99R <<-EOF
		LDPATH=${R_HOME}/lib
		R_HOME=${R_HOME}
	EOF
	doenvd 99R || die "doenvd failed"

	dobashcompletion "${WORKDIR}"/R.bash_completion
}

pkg_config() {
	if use java; then
		einfo "Re-initializing java paths for ${P}"
		R CMD javareconf
	fi
}
