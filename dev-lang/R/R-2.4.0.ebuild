# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/R/R-2.4.0.ebuild,v 1.2 2006/10/22 18:26:25 markusle Exp $

inherit fortran toolchain-funcs flag-o-matic

DESCRIPTION="R is GNU S - A language and environment for statistical computing and graphics."
HOMEPAGE="http://www.r-project.org/"
SRC_URI="mirror://cran/src/base/R-2/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="blas jpeg nls png readline tcltk X lapack"

RDEPEND=">=dev-lang/perl-5.6.1-r3
	readline? ( >=sys-libs/readline-4.1-r3 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	png? ( >=media-libs/libpng-1.2.1 )
	blas? ( virtual/blas )
	lapack? ( virtual/lapack )
	tcltk? ( dev-lang/tk )
	X? ( || ( ( x11-libs/libX11 )
		virtual/x11 ) )"
DEPEND="${RDEPEND}
	X? ( || ( ( x11-proto/xproto
		x11-libs/libXt
		x11-libs/libX11 )
		virtual/x11 ) )"

AT_M4DIR="${S}/m4"

pkg_setup() {
	# Test for a 64 bit architecture - f2c won't work on 64 bit archs with R.
	# Thanks to vapier for providing the test.
	cd "${T}"
	echo 'int main(){}' > test.c
	$(tc-getCC) -c test.c -o test.o
	if file test.o | grep -qs 64-bit ; then
		einfo "64 bit architecture detected, using g77 or gfortran."
		FORTRAN="gfortran g77 ifc"
	else
		FORTRAN="gfortran g77 f2c"
	fi
	rm -f test.{c,o}
	fortran_pkg_setup

	filter-ldflags -Wl,-Bdirect -Bdirect

	# this is needed to properly compile additional R packages
	# (see bug #152379)
	append-flags -std=gnu99
}

src_unpack() {
	unpack ${A}
	sed -i -e "s:-fpic:-fPIC:g" ${S}/configure
}

src_compile() {
	local myconf="--enable-R-profiling --enable-R-shlib --enable-linux-lfs"

	if use tcltk; then
		#configure needs to find the files tclConfig.sh and tkConfig.sh
		myconf="${myconf} --with-tcltk --with-tcl-config=/usr/lib/tclConfig.sh
			--with-tk-config=/usr/lib/tkConfig.sh"
	else
		myconf="${myconf} --without-tcltk"
	fi

	econf \
		$(use_enable nls) \
		$(use_with blas) \
		$(use_with lapack) \
		$(use_with jpeg jpeglib) \
		$(use_with png libpng) \
		$(use_with readline) \
		$(use_with X x) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		rhome=${D}/usr/$(get_libdir)/R \
		install || die "Installation Failed"

	# fix the R wrapper script to have the correct R_HOME_DIR
	# sed regexp borrowed from included debian rules
	sed \
		-e "/^R_HOME_DIR=.*/s::R_HOME_DIR=/usr/$(get_libdir)/R:" \
		-i ${D}/usr/$(get_libdir)/R/bin/R \
		|| die "sed failed."

	# The same kinds of seds are needed for these variables too, see bug 115140
	sed \
		-e "/^R_SHARE_DIR=.*/s::R_SHARE_DIR=/usr/$(get_libdir)/R/share:" \
		-e "/^R_INCLUDE_DIR=.*/s::R_INCLUDE_DIR=/usr/$(get_libdir)/R/include:" \
		-e "/^R_DOC_DIR=.*/s::R_DOC_DIR=/usr/$(get_libdir)/R/doc:" \
		-i ${D}/usr/$(get_libdir)/R/bin/R \
		|| die "sed failed."

	# R installs two identical wrappers under /usr/bin and /usr/lib/R/bin/
	# the 2nd one is corrected by above sed, the first is replaced by a symlink
	cd ${D}/usr/bin/
	rm R
	dosym ../$(get_libdir)/R/bin/R /usr/bin/R
	dodir /etc/env.d
	echo -n \
		"LDPATH=\"/usr/$(get_libdir)/R/lib\"" \
		> ${D}/etc/env.d/99R
	cd ${S}

	dodoc AUTHORS BUGS COPYING* ChangeLog FAQ *NEWS README \
		RESOURCES THANKS VERSION Y2K
}
