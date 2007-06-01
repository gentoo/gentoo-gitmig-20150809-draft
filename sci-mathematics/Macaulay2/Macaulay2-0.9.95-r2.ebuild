# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/Macaulay2/Macaulay2-0.9.95-r2.ebuild,v 1.2 2007/06/01 01:02:30 markusle Exp $

inherit elisp-common eutils flag-o-matic toolchain-funcs autotools

IUSE="emacs"

DESCRIPTION="research tool for commutative algebra and algebraic geometry"
SRC_URI="http://www.math.uiuc.edu/Macaulay2/Downloads/${P}-src.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Factory/factory-3-0-2.tar.gz \
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Libfac/libfac-3-0-2.tar.gz"

HOMEPAGE="http://www.math.uiuc.edu/Macaulay2/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="sys-libs/gdbm
	dev-libs/gmp
	dev-libs/ntl
	dev-libs/boehm-gc
	virtual/blas
	virtual/lapack
	dev-util/ctags
	sys-libs/ncurses
	emacs? ( virtual/emacs )"

SITEFILE=70Macaulay2-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-etags-gentoo.patch
	epatch "${FILESDIR}"/${P}-cpp-fix.patch
	epatch "${FILESDIR}"/${P}-test-fix.patch
}

src_compile() {
	cd "${WORKDIR}/factory"
	econf --enable-NTL --prefix="${WORKDIR}" || \
		die "failed to configure factory"
	emake || die "failed to build factory"
	make install || die "failed to install factory"

	cd "${WORKDIR}/libfac"
	CPPFLAGS="-I${WORKDIR}/include" econf --with-NOSTREAMIO \
		--prefix="${WORKDIR}" || die "failed to configure libfac"
	emake DEFS=-DHAVE_SINGULAR_ERROR || die "failed to build libfac"
	make install || die "failed to install libfac"

	cd "${S}"
	sed -e "/^docm2RelDir/s:Macaulay2:${P}:" \
		-i include/config.Makefile.in || \
		die "failed to fix makefile"

	CXXFLAGS="${CXXFLAGS} -Wno-deprecated"
	append-ldflags "-L${WORKDIR}/$(get_libdir)"
	emake -j1 && CPPFLAGS="-I/usr/include/gc -I${WORKDIR}/include" \
		./configure --prefix="${D}/usr" --disable-encap \
		--with-lapacklibs="-llapack -lblas" || \
		die "failed to configure Macaulay"
	emake -j1 || die "failed to build Macaulay"
}

src_test() {
	cd "${S}"
	make check || die "tests failed"
}

src_install () {
	cd "${S}"
	make install || die "install failed"

	# nothing in here, get rid of it
	rm -fr "${D}"/usr/$(get_libdir) || \
		die "failed to remove empty /usr/lib"

	use emacs && elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
		elog "If you want to set a hot key for Macaulay2 in Emacs add a line similar to"
		elog "(global-set-key [ f12 ] 'M2)"
		elog "in order to set it to F12 (or choose a different one."
	fi
}
pkg_postrm() {
	use emacs && elisp-site-regen
}
